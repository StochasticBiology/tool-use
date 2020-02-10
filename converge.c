// compute Gellman-Rubin convergence diagnostic for MCMC chains
// useful reference:
// https://astrostatistics.psu.edu/RLectures/diagnosticsMCMC.pdf
// at the moment everything is sloppily output to stdout -- could be streamlined

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAXN 100000
#define MAXM 4

int main(int argc, char *argv[])
{
  FILE *fp;
  double meantheta[MAXM];
  double vartheta[MAXM];
  double meanmeantheta;
  double W, B;
  double varvartheta;
  double Rhat;
  double *theta;
  int m, n;
  int i, j;
  char fstr[1000];
  double tmp;
  char ch;
  int k;

  int param;
  int skipper;
  
  // m is number of chains
  // n is length of chain

  if(argc < 1)
    {
      printf("Need list of files to analyse\n");
      return 0;
    }
  
  theta = (double*)malloc(sizeof(double)*MAXN*MAXM);

  // whether to skip entries, and how many
  skipper = 1;

  m = 3;

  // loop through parameters
  for(param = 0; param < 400; param++)
    {
      printf("Starting %i\n", param);

      // read in samples from each file
      for(j = 0; j < m; j++)
	{
	  fp = fopen(argv[j+1], "r");
	  if(fp == NULL)
	    {
	      printf("Couldn't open %s\n", argv[j+1]);
	      return 0;
	    }
	  else printf("Opening %s\n", argv[j+1]);
	  i = 0;
	  do{
	    for(k = 0; k <= param; k++)
	      fscanf(fp, "%lf", &tmp);
	    if(feof(fp)) break;
	    theta[j*MAXN+(i++)] = tmp;
	    for(k = 0; k < skipper; k++)
	      do{ch = fgetc(fp);}while(ch != '\n' && ch != EOF);
	  }while(!feof(fp));
	  fclose(fp);
	  printf("\nRead %i samples\n\n", i);
	}

      // how many samples to compute statistics over?
      n = 7500;

      // start computing statistics within and between chains
      meanmeantheta = 0;
      for(j = 0; j < m; j++)
	{
	  meantheta[j] = vartheta[j] = 0;
	  for(i = 0; i < n; i++)
	    {
	      meantheta[j] += theta[j*MAXN+i];
	    }
	  meantheta[j] /= n;
	  for(i = 0; i < n; i++)
	    {
	      vartheta[j] += (theta[j*MAXN+i] - meantheta[j])*(theta[j*MAXN+i] - meantheta[j]);
	    }
	  vartheta[j] /= (n-1);
	  meanmeantheta += meantheta[j];
	}
      meanmeantheta /= m;

      // compute overall summary statistics
      W = B = 0;
      for(j = 0; j < m; j++)
	{
	  W += vartheta[j];
	  B += (meantheta[j]-meanmeantheta)*(meantheta[j]-meanmeantheta);
	}
      W /= m;
      B *= ((double)n/(m-1));

      // compute GR statistic
      varvartheta = (1.-1./n)*W + 1./n*B;
      Rhat = sqrt(varvartheta/W);

      printf("Rhat %f\n", Rhat);
    }
  
  return 0;
}
      
