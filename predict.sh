# make predictions about hidden and future features, based on inferred routes

# sparsify output routes from posteriors.c -- a bit hacky
awk 'BEGIN{n=0;}{if(n%100==0) print $0; n++;}' ../total-observations.txt-trans.txt-posterior-0-1-3-5.txt-routes.txt > total-routes-sparse.txt

# compile and run predictions code (commented line runs on full set of routes) 
gcc predictions.c -o predictions.ce
#./predictions.ce 22 total-observations.txt total-observations.txt-trans.txt-posterior-0-1-3-5.txt-routes.txt
./predictions.ce 22 total-observations.txt total-routes-sparse.txt

