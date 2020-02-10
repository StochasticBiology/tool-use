# plot the inferred dynamics for wild/not-wild and aquatic/non-aquatic subsets

reset
set term svg size 640,480
set output "plotscr-aquatic-wild.svg"
set xrange [-1:22]
set yrange [0:23]

set ytics (5, 10, 15, 20)
set style fill solid
unset key
set ylabel "Acquisition ordering"
myscale = 1
set xtics ("Affix" 0, "Throw" 1, "Bait" 2, "Contain" 3, "Pry" 4, "Wave-shake" 5, "Block" 6, "Prop-climb" 7, "Dig" 8, "Scratch" 9, "Pound" 10, "Hang" 11, "Wipe" 12, "Insert-probe" 13, "Drop" 14, "Reach" 15, "Absorb" 16, "Drag-roll" 17, "Club" 18, "Jab-stab" 19, "Symbolize" 20, "Cut" 21) rotate

f_no_aquatic(x) = (x == 2 || x == 4 || x == 9 || x == 10 || x == 11 || x >= 13)

set key outside below
plot "../aquatic-total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u (f_no_aquatic($3) ? 1/0 : $3):($1+1):(sqrt($5)*myscale):(90):(180) w circles lc rgbcolor "#FF8888" title "Aquatic total", "../aquatic-wild-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u (f_no_aquatic($3) ? 1/0 : $3):($1+1):(sqrt($5)*myscale):(180):(270) w circles lc rgbcolor "#FFAAAA" title "Aquatic wild", "../nonaquatic-total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(270):(360) w circles lc rgbcolor "#8888FF" title "Non-aquatic total", "../nonaquatic-wild-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(0):(90) w circles lc rgbcolor "#AAAAFF" title "Non-aquatic wild"
quit
