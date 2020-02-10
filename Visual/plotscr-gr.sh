# plot Gellman-Rubin convergence statistic for MCMC convergence

reset
set term svg size 640,480
set output "plotscr-gr.svg"
unset key
set xrange [0.95:*]
set style fill solid
set ytics 0.1
set boxwidth 0.04
set xlabel "GR statistic"
set ylabel "Proportion of parameters"

plot "plot-gr.txt" u ($1):($2/400.) w boxes lc rgbcolor "#8888FF"
quit
