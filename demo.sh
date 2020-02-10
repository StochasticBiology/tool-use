# demonstration script illustrating a quick analysis of tool use data

chmod +x *.sh

# --- Stage 1 ---
# get names of species in dataset
cp Data/taxa-names.txt total-names.txt

# get observed patterns of tool use from source observed data
sed 's/2/1/g' Data/all-observations.txt > total-observations.txt

# --- Stage 2 ---
# use source phylogeny to phrase these observations as a set of transitions
./updatetree-linux.sh Data/all-commontree.txt > all-commontree-old.txt
gcc construct-barcodes.c -o construct-barcodes.ce
./construct-barcodes.ce total-names.txt total-observations.txt all-commontree-old.txt > total.tmp

# --- Stage 3 ---
# run HyperTraPS on this set of transitions
gcc -o3 hypertraps-dt.c -lm -o hypertraps-dt.ce
./hypertraps-dt.ce total-observations.txt-trans.txt 1 1 5 0 > total-run-demo.tmp&

# --- Stage 4 ---
# posterior analysis -- only run these when MCMC is complete
# gcc -o3 posteriors.c -lm -o posteriors.ce
# ./posteriors.ce 1 total-observations.txt-trans.txt-posterior-0-1-1-5.txt > analysis-demo.txt &

# --- Stage 5 ---
# no-frills visualisation of output
# gnuplot -e "set term svg size 400,400; unset key; set output \"demo-output.svg\"; set xlabel \"Feature\"; set ylabel \"Order\"; plot \"total-observations.txt-trans.txt-posterior-0-1-1-5.txt.process\" u 3:1:(\$5*10) ps variable pt 7; quit;"
