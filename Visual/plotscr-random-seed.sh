# plot the full inferred dynamics and version with different random number seed

reset
set xrange [-0.5:21.5]
set yrange [0.5:20.5]

unset key
set ylabel "Ordering"
myscale = 1
set xtics ("Affix" 0, "Throw" 1, "Bait" 2, "Contain" 3, "Pry" 4, "Wave-shake" 5, "Block" 6, "Prop-climb" 7, "Dig" 8, "Scratch" 9, "Pound" 10, "Hang" 11, "Wipe" 12, "Insert-probe" 13, "Drop" 14, "Reach" 15, "Absorb" 16, "Drag-roll" 17, "Club" 18, "Jab-stab" 19, "Symbolize" 20, "Cut" 21) rotate
plot "../total-names.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(0):(180) w circles, "../total-names.txt-trans.txt-posterior-0-2-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(180):(360) w circles
