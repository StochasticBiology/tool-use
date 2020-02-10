gcc converge.c -lm -o converge.ce
./converge.ce total-observations.txt-trans.txt-posterior-0-1-3-5.txt total-observations.txt-trans.txt-posterior-0-2-3-5.txt total-observations.txt-trans.txt-posterior-0-3-3-5.txt > convergence.txt
./parse-converge.sh convergence.txt > plot-gr.txt
