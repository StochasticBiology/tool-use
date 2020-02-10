# plot predict hidden and future behaviours

reset
set term svg size 640,480
set output "plotscr-predictions.svg"
unset key
set xrange [-1:22]
set yrange [-1:22]
set style fill solid
f(x) = sqrt(0.25*x)
plot "../total-observations.txt-hidden.txt" u 2:($3 == -1 || $3 <= 0.9 ? 1/0 : 21-$1):(f($3)):(270):(90) w circles lc rgbcolor "#FFAAAA", "../total-observations.txt-hidden.txt" u 2:($3 == -1 || $3 > 0.9 ? 1/0 : 21-$1):(f($3)):(270):(90) w circles lc rgbcolor "#AAAAAA", "../total-observations.txt-predict.txt" u 2:($3 == -1 ? 1/0 : 21-$1):(f($3)):(90):(270) w circles lc rgbcolor "#AAAAFF", "../total-observations.txt-predict.txt" u 2:($3 == -1 ? 21-$1 : 1/0) w p pt 1 lc rgbcolor "#AAAAAA"
quit
