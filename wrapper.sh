# this "wrapper" script calls various other scripts that each achieve one subproject (see README) in the overall analysis

chmod +x *.sh

# get/produce data, and set HyperTraPS running
./subset.sh
./parse-trees.sh
./hypertraps-long.sh
./synth.sh

# only run these when MCMC chains have finished
#./analysis.sh
#./predict.sh

# run these for all command-line visualisation
#cd Visual
#chmod +x plot-all.sh
#./plot-all.sh
