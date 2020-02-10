# runs analysis of HyperTraPS posteriors

gcc -o3 posteriors.c -lm -o posteriors.ce

# total dataset
./posteriors.ce 1 total-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-1.1.txt &

# alternative interpretations
./posteriors.ce 0 total-convergent-trans.txt-posterior-0-1-3-5.txt > analysis-2.1.txt &
./posteriors.ce 0 wild-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-2.2.txt &

# some observations excluded
./posteriors.ce 0 sample-observations-0.1-1-trans.txt-posterior-0-1-3-5.txt > analysis-3.11.txt &
./posteriors.ce 0 sample-observations-0.1-2-trans.txt-posterior-0-1-3-5.txt > analysis-3.12.txt &
./posteriors.ce 0 sample-observations-0.1-3-trans.txt-posterior-0-1-3-5.txt > analysis-3.13.txt &
./posteriors.ce 0 sample-observations-0.2-1-trans.txt-posterior-0-1-3-5.txt > analysis-3.21.txt &
./posteriors.ce 0 sample-observations-0.2-2-trans.txt-posterior-0-1-3-5.txt > analysis-3.22.txt &
./posteriors.ce 0 sample-observations-0.2-3-trans.txt-posterior-0-1-3-5.txt > analysis-3.23.txt &

# different classes
./posteriors.ce 0 aquatic-total-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.11.txt &
./posteriors.ce 0 aquatic-wild-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.12.txt &
./posteriors.ce 0 nonaquatic-total-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.21.txt &
./posteriors.ce 0 nonaquatic-wild-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.22.txt &
./posteriors.ce 0 primate-total-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.31.txt &
./posteriors.ce 0 primate-wild-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.32.txt &
./posteriors.ce 0 nonprimate-total-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.41.txt &
./posteriors.ce 0 nonprimate-wild-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.42.txt &
./posteriors.ce 0 bird-observations.txt-trans.txt-posterior-0-1-3-5.txt > analysis-5.5.txt &

# synthetic validation
./posteriors.ce 0 synth-0-0.txt-posterior-0-1-3-5.txt > analysis-4.1.txt &
./posteriors.ce 0 synth-0-1.txt-posterior-0-1-3-5.txt > analysis-4.2.txt &
./posteriors.ce 0 synth-0-2.txt-posterior-0-1-3-5.txt > analysis-4.3.txt &
./posteriors.ce 0 synth-1.1-0.txt-posterior-0-1-3-5.txt > analysis-4.4.txt &
./posteriors.ce 0 synth-1.1-1.txt-posterior-0-1-3-5.txt > analysis-4.5.txt &
./posteriors.ce 0 synth-1.1-2.txt-posterior-0-1-3-5.txt > analysis-4.6.txt &
./posteriors.ce 0 synth-1.2-0.txt-posterior-0-1-3-5.txt > analysis-4.7.txt &
./posteriors.ce 0 synth-1.2-1.txt-posterior-0-1-3-5.txt > analysis-4.8.txt &
./posteriors.ce 0 synth-1.2-2.txt-posterior-0-1-3-5.txt > analysis-4.9.txt &
./posteriors.ce 0 synth-1.4-0.txt-posterior-0-1-3-5.txt > analysis-4.10.txt &
./posteriors.ce 0 synth-1.4-1.txt-posterior-0-1-3-5.txt > analysis-4.11.txt &
./posteriors.ce 0 synth-1.4-2.txt-posterior-0-1-3-5.txt > analysis-4.12.txt &
./posteriors.ce 0 synth-2.txt-posterior-0-1-3-5.txt > analysis-4.13.txt &
./posteriors.ce 0 synth-2.1.txt-posterior-0-1-3-5.txt > analysis-4.14.txt &
./posteriors.ce 0 synth-2.2.txt-posterior-0-1-3-5.txt > analysis-4.15.txt &

# make a script allowing the automatic replacement of anonymous features in these outputs with the real tool mode names
more Data/modes.txt | awk 'BEGIN{n=0;}{printf("sed -i \"s/feature_%i /%s /g\" *process\n", n++, $0);}' > modescr.sh
chmod +x modescr.sh
./modescr.sh

# get means of inferred posteriors for subsampled data
chmod +x get-means.sh
./get-means.sh

# run convergence diagnostics
chmod +x convergence.sh
./convergence.sh

# compute predictions of hidden and future features
chmod +x predict.sh
./predict.sh

