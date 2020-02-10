#include <stdio.h>
#include <stdlib.h>

#define RND drand48()

int main(void)
{
  FILE *fp, *fp1, *fp2;
  int missing[22];
  int i, j;
  int k;

  char fstr[100];
  
  // default synthetic case
  for(k = 0; k < 3; k++)
    {
      sprintf(fstr, "synth-0-%i.txt", k);
      fp = fopen(fstr, "w");
      for(i = 0; i < 22; i++)
	{
	  for(j = 0; j < 22; j++)
	    fprintf(fp, "%i ", (i<j));
	  fprintf(fp, "\n");
	  for(j = 0; j < 22; j++)
	    fprintf(fp, "%i ", (i<=j));
	  fprintf(fp, "\n");
	}
      fclose(fp);
    }
    
  // some features are systematically undersampled
  for(k = 0; k < 3; k++)
    {
      sprintf(fstr, "synth-1.1-%i.txt", k);
      fp = fopen(fstr, "w");
      for(i = 0; i < 22; i++)
	{
	  for(j = 0; j < 22; j++)
	    missing[j] = (j % 2 == 0 && RND < 0.1);
	  for(j = 0; j < 22; j++)
	    fprintf(fp, "%i ", (i<j && !missing[j]));
	  fprintf(fp, "\n");
	  for(j = 0; j < 22; j++)
	    fprintf(fp, "%i ", (i<=j && !missing[j]));
	  fprintf(fp, "\n");
	}
      fclose(fp);
    }

  for(k = 0; k < 3; k++)
    {
      sprintf(fstr, "synth-1.2-%i.txt", k);
      fp = fopen(fstr, "w");
      for(i = 0; i < 22; i++)
	{
	  for(j = 0; j < 22; j++)
	    missing[j] = (j % 2 == 0 && RND < 0.2);
	  for(j = 0; j < 22; j++)
	    fprintf(fp, "%i ", (i<j && !missing[j]));
	  fprintf(fp, "\n");
	  for(j = 0; j < 22; j++)
	    fprintf(fp, "%i ", (i<=j && !missing[j]));
	  fprintf(fp, "\n");
	}
      fclose(fp);
    }

  for(k = 0; k < 3; k++)
    {
      sprintf(fstr, "synth-1.4-%i.txt", k);
      fp = fopen(fstr, "w");
      for(i = 0; i < 22; i++)
	{
	  for(j = 0; j < 22; j++)
	    missing[j] = (j % 2 == 0 && RND < 0.4);
	  for(j = 0; j < 22; j++)
	    fprintf(fp, "%i ", (i<j && !missing[j]));
	  fprintf(fp, "\n");
	  for(j = 0; j < 22; j++)
	    fprintf(fp, "%i ", (i<=j && !missing[j]));
	  fprintf(fp, "\n");
	}
      fclose(fp);
    }
		
  // one set of organisms evolves differently
  sprintf(fstr, "synth-2.txt");
  fp = fopen(fstr, "w");
  sprintf(fstr, "synth-2.1.txt");
  fp1 = fopen(fstr, "w");
  sprintf(fstr, "synth-2.2.txt");
  fp2 = fopen(fstr, "w");
      
  for(i = 0; i < 22; i++)
    {
      for(j = 0; j < 22; j++)
	{
	  fprintf(fp, "%i ", (i>j && j%3 != 0));
	  fprintf(fp1, "%i ", (i>j && j%3 != 0));
	}
      fprintf(fp, "\n");
      fprintf(fp1, "\n");
      for(j = 0; j < 22; j++)
	{
	  fprintf(fp, "%i ", (i>=j && j%3 != 0));
	  fprintf(fp1, "%i ", (i>=j && j%3 != 0));
	}
      fprintf(fp, "\n");
      fprintf(fp1, "\n");
      for(j = 0; j < 22; j++)
	{
	  fprintf(fp, "%i ", (i>j));
	  fprintf(fp2, "%i ", (i>j));
	}
      fprintf(fp, "\n");
      fprintf(fp2, "\n");
      for(j = 0; j < 22; j++)
	{
	  fprintf(fp, "%i ", (i>=j));
	  fprintf(fp2, "%i ", (i>=j));
	}
      fprintf(fp, "\n");
      fprintf(fp2, "\n");
    }
  fclose(fp);
  fclose(fp1);
  fclose(fp2);

  return 0;
}
