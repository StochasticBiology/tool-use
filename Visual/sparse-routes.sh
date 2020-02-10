awk 'BEGIN{n=0;}{if(n%100==0) print $0; n++;}' ../total-observations.txt-trans.txt-posterior-0-1-3-5.txt-routes.txt > total-routes-sparse.txt
