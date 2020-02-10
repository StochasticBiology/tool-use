./updatetree-linux.sh Data/all-commontree.txt > all-commontree-old.txt
./updatetree-linux.sh Data/primate-commontree.txt > primate-commontree-old.txt
./updatetree-linux.sh Data/nonprimate-commontree.txt > nonprimate-commontree-old.txt
./updatetree-linux.sh Data/aquatic-commontree.txt > aquatic-commontree-old.txt
./updatetree-linux.sh Data/nonaquatic-commontree.txt > nonaquatic-commontree-old.txt
./updatetree-linux.sh Data/bird-commontree.txt > bird-commontree-old.txt

gcc construct-barcodes.c -o construct-barcodes.ce

./construct-barcodes.ce total-names.txt wild-observations.txt all-commontree-old.txt > wild.tmp
./construct-barcodes.ce total-names.txt total-observations.txt all-commontree-old.txt > total.tmp
./construct-barcodes.ce primate-names.txt primate-total-observations.txt primate-commontree-old.txt > primate-total.tmp
./construct-barcodes.ce primate-names.txt primate-wild-observations.txt primate-commontree-old.txt > primate-wild.tmp
./construct-barcodes.ce nonprimate-names.txt nonprimate-total-observations.txt nonprimate-commontree-old.txt > nonprimate-total.tmp
./construct-barcodes.ce nonprimate-names.txt nonprimate-wild-observations.txt nonprimate-commontree-old.txt > nonprimate-wild.tmp
./construct-barcodes.ce aquatic-names.txt aquatic-total-observations.txt aquatic-commontree-old.txt > aquatic-total.tmp
./construct-barcodes.ce aquatic-names.txt aquatic-wild-observations.txt aquatic-commontree-old.txt > aquatic-wild.tmp
./construct-barcodes.ce nonaquatic-names.txt nonaquatic-total-observations.txt nonaquatic-commontree-old.txt > nonaquatic-total.tmp
./construct-barcodes.ce nonaquatic-names.txt nonaquatic-wild-observations.txt nonaquatic-commontree-old.txt > nonaquatic-wild.tmp
./construct-barcodes.ce bird-names.txt bird-observations.txt bird-commontree-old.txt > bird.tmp

./construct-barcodes.ce total-names.txt sample-observations-0.1-1.txt all-commontree-old.txt > sample-0.1-1.tmp
./construct-barcodes.ce total-names.txt sample-observations-0.1-2.txt all-commontree-old.txt > sample-0.1-2.tmp
./construct-barcodes.ce total-names.txt sample-observations-0.1-3.txt all-commontree-old.txt > sample-0.1-3.tmp
./construct-barcodes.ce total-names.txt sample-observations-0.2-1.txt all-commontree-old.txt > sample-0.2-1.tmp
./construct-barcodes.ce total-names.txt sample-observations-0.2-2.txt all-commontree-old.txt > sample-0.2-2.tmp
./construct-barcodes.ce total-names.txt sample-observations-0.2-3.txt all-commontree-old.txt > sample-0.2-3.tmp

