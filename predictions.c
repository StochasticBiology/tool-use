// make predictions about hidden and future features given sets of HyperTraPS routes

#include <stdio.h>
#include <stdlib.h>

#define MAXN 100

int main(int argc, char *argv[])
{
  FILE *fp;
  int *matrix;
  double norm_hidden[MAXN], norm_predict[MAXN];
  double *hidden, *predict;
  int i, j, k;
  int L;
  int n, nrec;
  int *thisset;
  int *thisstate;
  int tmp;
  int perfectmatch, onesmatch;
  char fstr[400];
  
  if(argc != 4)
    {
      printf("Need number of features, observations file, and routes file\n");
      return 0;
    }
  
  L = atoi(argv[1]);

  // allocate memory for counts
  matrix = (int*)malloc(sizeof(int)*L*MAXN);
  hidden = (double*)malloc(sizeof(double)*L*MAXN);
  predict = (double*)malloc(sizeof(double)*L*MAXN);
  thisset = (int*)malloc(sizeof(int)*L);
  thisstate = (int*)malloc(sizeof(int)*L);

  // read in observations (so we know which features we've observed in each case)
  n = 0;
  fp = fopen(argv[2], "r");
  if(fp == NULL)
    {
      printf("Couldn't open observations file %s\n", argv[2]);
      return 0;
    }
  do{
    fscanf(fp, "%i", &tmp);
    if(!feof(fp)) matrix[n++] = tmp;
  }while(!feof(fp));
  fclose(fp);
  nrec = n/L;

  // initialise predictions
  for(i = 0; i < L*MAXN; i++)
    hidden[i] = predict[i] = 0;
  for(i = 0; i < MAXN; i++)
    norm_hidden[i] = norm_predict[i] = 0;
  
  // read in routes
  fp = fopen(argv[3], "r");
  if(fp == NULL)
    {
      printf("Couldn't open routes file %s\n", argv[3]);
      return 0;
    }
  n = 0;
  do{
    // loop through routes file, getting one ordered set of L features at a time 
    for(i = 0; i < L; i++)
      {
	fscanf(fp, "%i", &thisset[i]);
	if(feof(fp)) break;
      }
    if(feof(fp)) break;
    if(n % 1000 == 0)
      printf("Read %i lines\n", n);
    n++;

    // start at an initial zero state
    for(i = 0; i < L; i++)
      thisstate[i] = 0;
    
    for(i = 0; i < L; i++)
      {
	// go through the read we've just read
	thisstate[thisset[i]] = 1;

	// does this state match any of our observed states (stored in matrix)?
	// we can either match perfectly (and make a prediction about the future)
	// or match all observed (1) states (and make a prediction about unobserved states)
	for(j = 0; j < nrec; j++)
	  {
	    perfectmatch = onesmatch = 1;
	    for(k = 0; k < L; k++)
	      {
		if(thisstate[k] != matrix[L*j + k]) perfectmatch = 0;
		if(thisstate[k] == 0 && matrix[L*j + k] == 1) onesmatch = 0;
	      }
	    if(perfectmatch && i < L-1)
	      {
		// if we have a perfect match, record the next feature to be acquired in this route as a future prediction
		predict[L*j + thisset[i+1]]++;
		norm_predict[j]++;
	      }
	    if(onesmatch)
	      {
		// if we have an "observed" match, record all 1s observed in this state as "hidden" predictions
		for(k = 0; k < L; k++)
		  hidden[L*j + k] += thisstate[k];
		norm_hidden[j]++;
	      }
	  }
      }
  }while(!feof(fp));
  fclose(fp);

  // output future predictions
  sprintf(fstr, "%s-predict.txt", argv[2]);
  fp = fopen(fstr, "w");
  for(j = 0; j < nrec; j++)
    {
      for(i = 0; i < L; i++)
	fprintf(fp, "%i %i %f\n", j, i, (matrix[L*j + i] == 1 ? -1 : predict[L*j + i]/norm_predict[j]));
    }
  fclose(fp);

  // output "hidden" predictions
  sprintf(fstr, "%s-hidden.txt", argv[2]);
  fp = fopen(fstr, "w");
  for(j = 0; j < nrec; j++)
    {
      for(i = 0; i < L; i++)
	fprintf(fp, "%i %i %f\n", j, i, (matrix[L*j + i] == 1 ? -1 : hidden[L*j + i]/norm_hidden[j]));
    }
  fclose(fp);

  return 0;
}
