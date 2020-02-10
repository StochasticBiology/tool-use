# runs long HyperTraPS simulations for all subsets of the data we're interested in

gcc -o3 hypertraps-dt.c -lm -o hypertraps-dt.ce

./hypertraps-dt.ce total-observations.txt-trans.txt 1 3 5 0 > total-run1.tmp &
./hypertraps-dt.ce total-convergent-trans.txt 1 3 5 0 > totalconv-run1.tmp &
./hypertraps-dt.ce wild-observations.txt-trans.txt 1 3 5 0 > wild-run1.tmp &

./hypertraps-dt.ce aquatic-total-observations.txt-trans.txt 1 3 5 0 > aquatic-total-run1.tmp &
./hypertraps-dt.ce aquatic-wild-observations.txt-trans.txt 1 3 5 0 > aquatic-wild-run1.tmp &
./hypertraps-dt.ce nonaquatic-total-observations.txt-trans.txt 1 3 5 0 > nonaquatic-total-run1.tmp &
./hypertraps-dt.ce nonaquatic-wild-observations.txt-trans.txt 1 3 5 0 > nonaquatic-wild-run1.tmp &
./hypertraps-dt.ce primate-total-observations.txt-trans.txt 1 3 5 0 > primate-total-run1.tmp &
./hypertraps-dt.ce primate-wild-observations.txt-trans.txt 1 3 5 0 > primate-wild-run1.tmp &
./hypertraps-dt.ce nonprimate-total-observations.txt-trans.txt 1 3 5 0 > nonprimate-total-run1.tmp &
./hypertraps-dt.ce nonprimate-wild-observations.txt-trans.txt 1 3 5 0 > nonprimate-wild-run1.tmp &
./hypertraps-dt.ce bird-observations.txt-trans.txt 1 3 5 0 > bird-run1.tmp &

./hypertraps-dt.ce total-observations.txt-trans.txt 2 3 5 0 > total-run2.tmp &
./hypertraps-dt.ce total-observations.txt-trans.txt 3 3 5 0 > total-run3.tmp &

./hypertraps-dt.ce sample-observations-0.1-1-trans.txt 1 3 5 0 > sample-0.1-1-run.tmp &
./hypertraps-dt.ce sample-observations-0.1-2-trans.txt 1 3 5 0 > sample-0.1-2-run.tmp &
./hypertraps-dt.ce sample-observations-0.1-3-trans.txt 1 3 5 0 > sample-0.1-3-run.tmp &
./hypertraps-dt.ce sample-observations-0.2-1-trans.txt 1 3 5 0 > sample-0.2-1-run.tmp &
./hypertraps-dt.ce sample-observations-0.2-2-trans.txt 1 3 5 0 > sample-0.2-2-run.tmp &
./hypertraps-dt.ce sample-observations-0.2-3-trans.txt 1 3 5 0 > sample-0.2-3-run.tmp &

