# plot the inferred dynamics for wild/not-wild and primate/non-primate subsets

reset
set term svg size 640,480
set output "plotscr-primate-wild.svg"
set xrange [-1:22]
set yrange [0:23]

set ytics (5, 10, 15, 20)
set style fill solid
unset key
set ylabel "Acquisition ordering"
myscale = 1
set xtics ("Affix" 0, "Throw" 1, "Bait" 2, "Contain" 3, "Pry" 4, "Wave-shake" 5, "Block" 6, "Prop-climb" 7, "Dig" 8, "Scratch" 9, "Pound" 10, "Hang" 11, "Wipe" 12, "Insert-probe" 13, "Drop" 14, "Reach" 15, "Absorb" 16, "Drag-roll" 17, "Club" 18, "Jab-stab" 19, "Symbolize" 20, "Cut" 21) rotate

f_no_non_primate(x) = (x == 11 || x >= 20)

set key outside below
plot "../primate-total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(90):(180) w circles lc rgbcolor "#FF8888" title "Primate total", "../primate-wild-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u 3:($1+1):(sqrt($5)*myscale):(180):(270) w circles lc rgbcolor "#FFAAAA" title "Primate wild", "../nonprimate-total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u (f_no_non_primate($3) ? 1/0 : $3):($1+1):(sqrt($5)*myscale):(270):(360) w circles lc rgbcolor "#8888FF" title "Non-primate total", "../nonprimate-wild-observations.txt-trans.txt-posterior-0-1-3-5.txt.process" u (f_no_non_primate($3) ? 1/0 : $3):($1+1):(sqrt($5)*myscale):(0):(90) w circles lc rgbcolor "#AAAAFF" title "Non-primate wild"
