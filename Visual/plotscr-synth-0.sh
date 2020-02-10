# plot output of synthetic studies, random number seed 0

reset
set term svg size 800,800
set output "plotscr-synth-0.svg"
set multiplot
set size 0.5,0.5

set xrange [-1:22]
set yrange [-1:22]
unset key
f(x) = x*12
set origin 0,0.5
plot "../synth-0-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7 lc rgbcolor "#FF8888"
set origin 0.5,0.5
plot "../synth-1.1-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7 lc rgbcolor "#FF8888"
set origin 0.,0
plot "../synth-1.2-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7 lc rgbcolor "#FF8888"
set origin 0.5,0.
plot "../synth-2-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7 lc rgbcolor "#FF8888"
quit
