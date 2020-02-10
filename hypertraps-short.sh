gcc -o3 hypertraps-dt.c -lm -o hypertraps-dt.ce

./hypertraps-dt.ce total-names.txt-trans.txt 1 1 5 0 > total-run.tmp &
./hypertraps-dt.ce total-convergent-trans.txt 1 1 5 0 > totalconv-run.tmp &
./hypertraps-dt.ce wild-names.txt-trans.txt 1 1 5 0 > wild-run.tmp &
./hypertraps-dt.ce aquatic-taxa-names.txt-trans.txt 1 1 5 0 > aquatic-run.tmp &
./hypertraps-dt.ce nonaquatic-taxa-names.txt-trans.txt 1 1 5 0 > nonaquatic-run.tmp &
./hypertraps-dt.ce primate-taxa-names.txt-trans.txt 1 1 5 0 > primate-run.tmp &
./hypertraps-dt.ce nonprimate-taxa-names.txt-trans.txt 1 1 5 0 > nonprimate-run.tmp &
