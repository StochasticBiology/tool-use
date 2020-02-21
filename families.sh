# this script wraps the analysis of the family-level data

cp Data/families-data.txt .
cp Data/families-names.txt .

chmod +x updatetree-linux.sh
./updatetree-linux.sh Data/families-tree.txt > families-tree-old.txt
gcc construct-barcodes.c -o construct-barcodes.ce
./construct-barcodes.ce families-names.txt families-data.txt families-tree-old.txt > families.tmp

gcc -o3 hypertraps-dt.c -lm -o hypertraps-dt.ce
./hypertraps-dt.ce families-data.txt-trans.txt 1 3 5 0 > families-run.tmp &

# when HyperTraPS is finished
# gcc -o3 posteriors.c -lm -o posteriors.ce
# ./posteriors.ce 0 families-data.txt-trans.txt-posterior-0-1-3-5.txt

