# plot the full inferred dynamics and the dynamics assuming complete convergence

reset
set term svg size 640,480
set output "plotscr-total.svg"
unset key
set ylabel "Acquisition ordering"
set xrange [-1:22]
set yrange [0:23]
set xtics ("Affix" 0, "Throw" 1, "Bait" 2, "Contain" 3, "Pry" 4, "Wave-shake" 5, "Block" 6, "Prop-climb" 7, "Dig" 8, "Scratch" 9, "Pound" 10, "Hang" 11, "Wipe" 12, "Insert-probe" 13, "Drop" 14, "Reach" 15, "Absorb" 16, "Drag-roll" 17, "Club" 18, "Jab-stab" 19, "Symbolize" 20, "Cut" 21) rotate
plot "../total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*10) ps variable pt 7 lc rgbcolor "#8888FF", "../total-convergent-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*10) ps variable pt 6 lc rgbcolor "#FF8888"
quit
