# plot output of synthetic studies with different acquisition pathways

reset
set term svg size 640,640
set output "plotscr-synth-2.svg"
set multiplot
set size 1,0.5

set xrange [-1:22]
set yrange [-1:22]
unset key
set style fill solid
f(x) = sqrt(x*0.25)

set xlabel "Feature"
set ylabel "Acquisition order"
set origin 0,0.5
plot "../synth-2.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(0):(360) w circles lc rgbcolor "#000000"

set origin 0,0
plot "../synth-2.1.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(90):(270) w circles lc rgbcolor "#FF8888", "../synth-2.2.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)):(270):(90) w circles lc rgbcolor "#8888FF"
quit
