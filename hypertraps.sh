gcc -o3 hypertraps-dt.c -lm -o hypertraps-dt.ce

./hypertraps-dt.ce total-names.txt-trans.txt 1 1 5 1 > total-run.tmp &
./hypertraps-dt.ce wild-names.txt-trans.txt 1 1 5 1 > wild-run.tmp &
./hypertraps-dt.ce aquatic-taxa-names.txt-trans.txt 1 1 5 1 > aquatic-run.tmp &
./hypertraps-dt.ce nonaquatic-taxa-names.txt-trans.txt 1 1 5 1 > nonaquatic-run.tmp &
./hypertraps-dt.ce primate-taxa-names.txt-trans.txt 1 1 5 1 > primate-run.tmp &
./hypertraps-dt.ce nonprimate-taxa-names.txt-trans.txt 1 1 5 1 > nonprimate-run.tmp &
