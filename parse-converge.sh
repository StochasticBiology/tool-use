grep "Rhat" $1 | awk 'BEGIN{for(i=0;i<100;i++)hist[i] = 0;}{hist[int($2*10)]++;}END{for(i=0;i<100;i++){if(hist[i]) print i/10., hist[i];}}'
