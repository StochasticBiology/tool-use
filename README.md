# tool-use
HyperTraPS analysis of tool use patterns in animals

C and bash code for the organisation and HyperTraPS analysis of the dynamics pathways of tool use emergence across animal taxa. Gnuplot and Mathematica are used for visualisation.

The pipeline proceeds through five stages:
1. Initial data curation and subsetting, and synthetic data construction.
2. Constructing lists of transitions. For phylogenetically embedded data, this involves estimation of ancestral states from phylogeny structure and subsequent registration of transitions. For non-phylogenetic data, it involves simple registration of transitions from the initial precursor state to each independent observation.
3. HyperTraPS inference on lists of transitions.
4. Analysis of posteriors from HyperTraPS.
5. Plotting results.

demo.sh and wrapper.sh go through these stages for a simple demonstration case and the full project respectively. Demonstration case should take a few minutes (but the MCMC chains will likely not have converged). Full project should run overnight. Additionally, families.sh acts as a wrapper for the analysis of the family-level data.

clean.sh removes any outputs of inference simulations for housekeeping.

Source datasets are held in Data/ . These include sets of wild or not-wild observations, the lists of corresponding taxa, and the output of NCBI Common Taxonomy Tree phylogenetically linking these taxa.

Visualisation code (using Gnuplot and Mathematica) is held in Visual/ .

Individual source code files are described below. ** marks a "wrapper" script for each stage of analysis.

--- Stage 1 ---

** subset.sh -- Bash script using awk and sed to construct datasets for use below. From the data in Data/ , sets of wild- and total-observed features, artificially subsampled datasets, and datasets subsetted by taxa and lifestyle are produced.

synth.c -- C code to produce synthetic datasets

synth.sh -- compiles and runs synth.c (also runs HyperTraPS on these data, ie Stage 3)

--- Stage 2 ---

** parse-trees.sh -- compiles the code below and applies it to the datasets from Stage 1.

updatetree-linux.sh -- Bash script taking modern NCBI Common Taxonomy Tree output and casting in an older format that is read by the code below.

construct-barcodes.c -- C code to construct lists of transitions from observations and phylogeny structure. Takes a list of observed leaves, observed states of those leaves, and a phylogenetic tree in the output format from updatetree-linux.sh . Produces a list of transitions, and descriptions of the edges and labels of the corresponding phylogeny for use in visualisation.

--- Stage 3 ---

** hypertraps-long.sh -- compiles hypertraps-dt.c and applies it to the subsets of data from Stage 2.

hypertraps-dt.c -- C code running HyperTraPS. Takes various command line arguments including filename where list of transitions is stored. Another argument determines the length of the MCMC chain to run; the demonstration script selects a short time, the full project script selects a long time.

--- Stage 4 ---

** analysis.sh -- compiles posteriors.c and applies it to the posteriors from Stage 3. Also runs get-means.sh, predict.sh, and convergence.sh .

posteriors.c -- C code to simulate trajectories on the posterior hypercubes from HyperTraPS and report statistics of these pathways. Takes a "verbose" flag (0 or 1) and filename(s) storing posteriors. If verbose is 1, (large) samples of individual routes are output (used for predictions and plotting hypercubes). If not, output consists of "heatmap" ordering plots.

predictions.c -- C code that takes a number of features and a (sparsified) set of routes output from posteriors.c (via sparse-routes.sh), and the samples from the original dataset, and makes predictions about potentially hidden and future features. 

get-means.sh -- extracts the mean inferred ordering for each feature in a subset of subprojects, used for plotting below

predict.sh -- sparsifies reported routes (so that processing doesn't take too long -- a bit hacky!), and compiles and runs predictions.c to get predicted hidden and future features.

converge.c -- C code computing the distribution of Gellman-Rubin convergence statistics for MCMC chains across parameterisations from the Stage 3 inference. Output to stdout, which gets parsed by parse-converge.sh (could be streamlined!)

parse-converge.sh -- hacky script parsing the output of converge.c and preparing for plotting

convergence.sh -- compiles converge.c and applies it to output of Stage 3; parses the output and produces a summary of Gellman-Rubin statistics for plotting.

--- Stage 5 ---

** Visual/plot-all.sh -- runs all the above scripts and converts some of the (SVG) outputs to PNG format

Visual/plotscr-*.sh -- Gnuplot scripts plotting results from individual subprojects

Visual/plot-paths.nb -- Mathematica notebook that takes the (sparsified) set of routes output from Stage 4 and plots visualisations of the hypercubic transition networks involved.

The figures in the corresponding manuscript are produced by:

Fig 1 -- (data plot)
Fig 2 -- plotscr-total.sh & plot-paths.nb
Fig 3 -- plotscr-aquatic.sh, plotscr-primate.sh & plot-paths.nb
Fig 4 -- plotscr-predictions.sh 
Fig S1 -- plotscr-perturb-0.1.sh & plotscr-perturb-0.2.sh
Fig S2 -- plotscr-wild.sh
Fig S3 -- plotscr-aquatic-wild.sh & plotscr-primate-wild.sh
Fig S4 -- plotscr-bird.sh & (data plot)
Fig S5 -- plotscr-gr.sh
Fig S6 -- plotscr-synth-0.sh & plotscr-synth-1.sh
Fig S7 -- plotscr-synth-2.sh 
