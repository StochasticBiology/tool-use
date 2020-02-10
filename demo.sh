chmod +x *.sh

cp Data/taxa-names.txt total-names.txt

sed 's/2/1/g' Data/all-observations.txt > total-observations.txt
./updatetree-linux.sh Data/all-commontree.txt > all-commontree-old.txt
gcc construct-barcodes.c -o construct-barcodes.ce
./construct-barcodes.ce total-names.txt total-observations.txt all-commontree-old.txt > total.tmp

gcc -o3 hypertraps-dt.c -lm -o hypertraps-dt.ce
./hypertraps-dt.ce total-observations.txt-trans.txt 1 1 5 0 > total-run-demo.tmp&

# only run these when MCMC is complete
# gcc -o3 posteriors.c -lm -o posteriors.ce
# ./posteriors.ce 1 total-observations.txt-trans.txt-posterior-0-1-1-5.txt > analysis-demo.txt &

# gnuplot -e "set term svg size 400,400; unset key; set output \"demo-output.svg\"; set xlabel \"Feature\"; set ylabel \"Order\"; plot \"total-observations.txt-trans.txt-posterior-0-1-1-5.txt.process\" u 3:1:(\$5*10) ps variable pt 7; quit;"
