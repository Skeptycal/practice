set term postscript enhanced color solid 30
set xlabel "year"
set log y
set grid
set key left top

set format y "10^{%L}"

set out "year_freq.eps"
set xtics 1970,10
set ylabel "clock frequency (MHz)"
plot "< cat clockfreq*.dat" t '' pt 6 \
 , 100*4**((x-1995)/3) t 'moore' lt 3



set out "year_mips.eps"
set ylabel "MIPS"
plot "mipsperbuck.dat" t '' pt 6 \
 , 100*4**((x-1995)/3) t 'moore' lt 3


set out "year_flops.eps"
set ylabel "peak performance (GFlops)"
set xtics 2000,5
plot \
  "< ./preprocess.hs cpuflops.csv" t 'CPU' w lp pt 6 lw 2 \
, "< ./preprocess.hs gpuflops.csv" t 'GPU' w lp pt 6 lw 2 \
, 10*4**((x-2002)/3) t 'moore' lt 3 \
, 7*4**((x-2003.5)/3) t '' lt 3



set out "year_top500.eps"
set xtics 1990,10
set ylabel "Linpack Max (Flops)"
set xrange [1993:2025]
set yrange [1e7:1e20]
load "top500-labels.txt"
plot "top500.dat" t '' pt 6 \
 , 59.7e9*2**((x-1993.5)) t 'x2 every year' lt 2\
 , 59.7e9*4**((x-1993.5)/3) t 'moore' lt 3
