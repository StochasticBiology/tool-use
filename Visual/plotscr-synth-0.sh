# plot output of synthetic studies, random number seed 0

reset
set term svg size 800,480
set output "plotscr-synth-0.svg"
set multiplot
set style fill solid
set size 0.33,1

set xrange [-1:22]
set yrange [-1:22]
unset key
set xlabel "Feature"
set ylabel "Inferred ordering"
f(x) = x*6
set origin 0,0
set label 1 at 1, 1 "A" front font "Arial, 24"
plot "../synth-0-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(90):(270) w circles lc rgbcolor "#FF8888", "../synth-0-2.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(270):(90) w circles lc rgbcolor "#8888FF"
set origin 0.33,0
set label 1 at 1, 1 "B" front font "Arial, 24"
plot "../synth-1.1-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(90):(270) w circles lc rgbcolor "#FF8888", "../synth-1.1-2.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(270):(90) w circles lc rgbcolor "#8888FF"
set origin 0.66,0
set label 1 at 1, 1 "C" front font "Arial, 24"
plot "../synth-1.2-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(90):(270) w circles lc rgbcolor "#FF8888", "../synth-1.2-2.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(270):(90) w circles lc rgbcolor "#8888FF"

quit
