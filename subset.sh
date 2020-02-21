# this script produces the various variations and subsets of the original data that will be used in the analysis

# produce wild and total observed datasets
sed 's/1/0/g' Data/all-observations.txt | sed 's/2/1/g' > wild-observations.txt
sed 's/2/1/g' Data/all-observations.txt > total-observations.txt

# get taxa names
cp Data/taxa-names.txt total-names.txt

# produce transition set assuming convergent evolution
awk '{for(i=0;i<NF;i++) printf("0 "); printf("\n%s\n", $0);}' total-observations.txt > total-convergent-trans.txt

# produce randomly sampled transition sets:
# random perturbation
awk 'BEGIN{srand(1);}{for(i=1;i<=NF;i++) {if($i == 1) {if(rand()>0.1) printf("1 "); else printf("0 ");} if($i == 0) {if(rand()>0.1) printf("0 "); else printf("1 ");}} printf("\n");}' total-observations.txt > sample-observations-0.1-1.txt
awk 'BEGIN{srand(2);}{for(i=1;i<=NF;i++) {if($i == 1) {if(rand()>0.1) printf("1 "); else printf("0 ");} if($i == 0) {if(rand()>0.1) printf("0 "); else printf("1 ");}} printf("\n");}' total-observations.txt > sample-observations-0.1-2.txt
awk 'BEGIN{srand(3);}{for(i=1;i<=NF;i++) {if($i == 1) {if(rand()>0.1) printf("1 "); else printf("0 ");} if($i == 0) {if(rand()>0.1) printf("0 "); else printf("1 ");}} printf("\n");}' total-observations.txt > sample-observations-0.1-3.txt
awk 'BEGIN{srand(11);}{for(i=1;i<=NF;i++) {if($i == 1) {if(rand()>0.2) printf("1 "); else printf("0 ");} if($i == 0) {if(rand()>0.2) printf("0 "); else printf("1 ");}} printf("\n");}' total-observations.txt > sample-observations-0.2-1.txt
awk 'BEGIN{srand(2);}{for(i=1;i<=NF;i++) {if($i == 1) {if(rand()>0.2) printf("1 "); else printf("0 ");} if($i == 0) {if(rand()>0.2) printf("0 "); else printf("1 ");}} printf("\n");}' total-observations.txt > sample-observations-0.2-2.txt
awk 'BEGIN{srand(3);}{for(i=1;i<=NF;i++) {if($i == 1) {if(rand()>0.2) printf("1 "); else printf("0 ");} if($i == 0) {if(rand()>0.2) printf("0 "); else printf("1 ");}} printf("\n");}' total-observations.txt > sample-observations-0.2-3.txt

# random new observations
awk 'BEGIN{srand(1);}{for(i=1;i<=NF;i++) {if($i == 0) {if(rand()>0.1) printf("0 "); else printf("1 ");} else printf("1 ");} printf("\n");}' total-observations.txt > sample-observations-0.1-4.txt
awk 'BEGIN{srand(2);}{for(i=1;i<=NF;i++) {if($i == 0) {if(rand()>0.1) printf("0 "); else printf("1 ");} else printf("1 ");} printf("\n");}' total-observations.txt > sample-observations-0.1-5.txt
awk 'BEGIN{srand(3);}{for(i=1;i<=NF;i++) {if($i == 0) {if(rand()>0.1) printf("0 "); else printf("1 ");} else printf("1 ");} printf("\n");}' total-observations.txt > sample-observations-0.1-6.txt
awk 'BEGIN{srand(1);}{for(i=1;i<=NF;i++) {if($i == 0) {if(rand()>0.2) printf("0 "); else printf("1 ");} else printf("1 ");} printf("\n");}' total-observations.txt > sample-observations-0.2-4.txt
awk 'BEGIN{srand(2);}{for(i=1;i<=NF;i++) {if($i == 0) {if(rand()>0.2) printf("0 "); else printf("1 ");} else printf("1 ");} printf("\n");}' total-observations.txt > sample-observations-0.2-5.txt
awk 'BEGIN{srand(3);}{for(i=1;i<=NF;i++) {if($i == 0) {if(rand()>0.2) printf("0 "); else printf("1 ");} else printf("1 ");} printf("\n");}' total-observations.txt > sample-observations-0.2-6.txt

# produce wild and total primate subsets
awk 'BEGIN{n=1;}{if(n<=8) print $0; n++;}' total-observations.txt > primate-total-observations.txt
awk 'BEGIN{n=1;}{if(n<=8) print $0; n++;}' wild-observations.txt > primate-wild-observations.txt
awk 'BEGIN{n=1;}{if(n> 8) print $0; n++;}' total-observations.txt > nonprimate-total-observations.txt
awk 'BEGIN{n=1;}{if(n> 8) print $0; n++;}' wild-observations.txt > nonprimate-wild-observations.txt
awk 'BEGIN{n=1;}{if(n<=8) print $0; n++;}' Data/taxa-names.txt > primate-names.txt
awk 'BEGIN{n=1;}{if(n> 8) print $0; n++}' Data/taxa-names.txt > nonprimate-names.txt

# produce wild and total aquatic subsets
awk 'BEGIN{n=1;}{if(n==10 || n==15 || n==21 || n==22) print $0; n++;}' total-observations.txt > aquatic-total-observations.txt
awk 'BEGIN{n=1;}{if(n==10 || n==15 || n==21 || n==22) print $0; n++;}' wild-observations.txt > aquatic-wild-observations.txt
awk 'BEGIN{n=1;}{if(!(n==10 || n==15 || n==21 || n==22)) print $0; n++;}' total-observations.txt > nonaquatic-total-observations.txt
awk 'BEGIN{n=1;}{if(!(n==10 || n==15 || n==21 || n==22)) print $0; n++;}' wild-observations.txt > nonaquatic-wild-observations.txt
awk 'BEGIN{n=1;}{if(n==10 || n==15 || n==21 || n==22) print $0; n++;}' Data/taxa-names.txt > aquatic-names.txt
awk 'BEGIN{n=1;}{if(!(n==10 || n==15 || n==21 || n==22)) print $0; n++;}' Data/taxa-names.txt > nonaquatic-names.txt

# get bird observations
cp Data/bird-observations.txt .
cp Data/bird-names.txt .


