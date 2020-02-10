gcc synth.c -o synth.ce
./synth.ce

./hypertraps-dt.ce synth-0-0.txt 1 3 5 0 > synth0-0-run1.tmp &
./hypertraps-dt.ce synth-0-1.txt 1 3 5 0 > synth0-1-run1.tmp &
./hypertraps-dt.ce synth-0-2.txt 1 3 5 0 > synth0-2-run1.tmp &

./hypertraps-dt.ce synth-1.1-0.txt 1 3 5 0 > synth1.1-0-run1.tmp &
./hypertraps-dt.ce synth-1.1-1.txt 1 3 5 0 > synth1.1-1-run1.tmp &
./hypertraps-dt.ce synth-1.1-2.txt 1 3 5 0 > synth1.1-2-run1.tmp &

./hypertraps-dt.ce synth-1.2-0.txt 1 3 5 0 > synth1.2-0-run1.tmp &
./hypertraps-dt.ce synth-1.2-1.txt 1 3 5 0 > synth1.2-1-run1.tmp &
./hypertraps-dt.ce synth-1.2-2.txt 1 3 5 0 > synth1.2-2-run1.tmp &

./hypertraps-dt.ce synth-1.4-0.txt 1 3 5 0 > synth1.4-0-run1.tmp &
./hypertraps-dt.ce synth-1.4-1.txt 1 3 5 0 > synth1.4-1-run1.tmp &
./hypertraps-dt.ce synth-1.4-2.txt 1 3 5 0 > synth1.4-2-run1.tmp &

./hypertraps-dt.ce synth-2.txt 1 3 5 0 > synth2-0-run1.tmp &
./hypertraps-dt.ce synth-2.1.txt 1 3 5 0 > synth2-1-run1.tmp &
./hypertraps-dt.ce synth-2.2.txt 1 3 5 0 > synth2-2-run1.tmp &
