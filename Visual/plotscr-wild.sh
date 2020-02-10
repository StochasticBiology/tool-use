# plot the full inferred dynamics and the dynamics using only wild observations

reset
set term svg size 640,480
set output "plotscr-wild.svg"
unset key
set style fill solid

set yrange [0:23]
set ylabel "Ordering"
set xtics ("Affix" 0, "Throw" 1, "Bait" 2, "Contain" 3, "Pry" 4, "Wave-shake" 5, "Block" 6, "Prop-climb" 7, "Dig" 8, "Scratch" 9, "Pound" 10, "Hang" 11, "Wipe" 12, "Insert-probe" 13, "Drop" 14, "Reach" 15, "Absorb" 16, "Drag-roll" 17, "Club" 18, "Jab-stab" 19, "Symbolize" 20, "Cut" 21) rotate
f(x) = sqrt(x)
plot "../total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(f($5)):(0):(180) w circles lc rgbcolor "#8888FF", "../wild-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(f($5)):(180):(360) w circles lc rgbcolor "#FF8888"
quit
