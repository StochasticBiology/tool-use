# plot the full inferred dynamics and versions with different amounts of perturbed sampling

reset
set term svg size 640,640
set output "plotscr-perturb-0.2-2.svg"
set multiplot
set xrange [-1:22]
set yrange [0:23]

set ytics (5, 10, 15, 20)
set style fill solid
unset key
set ylabel "Acquisition ordering"
myscale = 1
set xtics ("Affix" 0, "Throw" 1, "Bait" 2, "Contain" 3, "Pry" 4, "Wave-shake" 5, "Block" 6, "Prop-climb" 7, "Dig" 8, "Scratch" 9, "Pound" 10, "Hang" 11, "Wipe" 12, "Insert-probe" 13, "Drop" 14, "Reach" 15, "Absorb" 16, "Drag-roll" 17, "Club" 18, "Jab-stab" 19, "Symbolize" 20, "Cut" 21) rotate


set bmargin at screen 0.1
set tmargin at screen 0.7
set rmargin at screen 0.95
set lmargin at screen 0.1

plot "../total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(0):(360) w circles lc rgbcolor "#CCCCCC", "../sample-observations-0.2-4.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(0):(45) w circles lc rgbcolor "#FF8888", "../sample-observations-0.2-5.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(120):(165) w circles lc rgbcolor "#FF8888", "../sample-observations-0.2-6.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(240):(285) w circles lc rgbcolor "#FF8888"

set xtics ("" 0, "" 1, "" 2, "" 3, "" 4, "" 5, "" 6, "" 7, "" 8, "" 9, "" 10, "" 11, "" 12, "" 13, "" 14, "" 15, "" 16, "" 17, "" 18, "" 19, "" 20, "" 21)
set bmargin at screen 0.7
set tmargin at screen 0.95
set ylabel "Mean\nordering"
set key top left
plot "means-total.txt" pt 7 lc rgbcolor "#CCCCCC" title "Original", "means-sample-0.2-4.txt" pt 1 lc rgbcolor "#FF8888" title "10% perturbations", "means-sample-0.2-5.txt" pt 1 lc rgbcolor "#FF8888" notitle, "means-sample-0.2-6.txt" pt 1 lc rgbcolor "#FF8888" notitle
quit
