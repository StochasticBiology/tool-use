# plot output of synthetic studies

reset
set multiplot
set size 0.33,0.5

unset key
f(x) = x*8
set origin 0,0.5
plot "../synth-0-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7
set origin 0.33,0.5
plot "../synth-1.1-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7
set origin 0.66,0.5
plot "../synth-1.2-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7
set origin 0.,0.
plot "../synth-1.4-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7
set origin 0.33,0.
plot "../synth-2-0.txt-posterior-0-1-3-5.txt.process" u 3:1:(f($5)) ps variable pt 7
