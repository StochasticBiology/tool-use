cp Code/* .
chmod +x *.sh

./subset.sh
./parse-trees.sh
./hypertraps-long.sh
./synth.sh

# only run this when MCMC chains have finished
#./analysis.sh
#./predict.sh

#cd Visual
#chmod +x plot-all.sh
#./plot-all.sh
