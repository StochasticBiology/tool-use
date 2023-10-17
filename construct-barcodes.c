// this code builds the set of HyperTraPS transitions for a given phylogeny
// we use an old-format NCBI text tree (can be obtained from a modern one with accompanying script), a list of species of interest, and a corresponding list of traits
// we use maximum parsimony to estimate ancestral node states, and hence build the list of transitions that have occurred from ancestor to descendant down the tree

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define LEN 200
#define MAXL 1000

// apply parsimony to reconstruct ancestral states
void Construct(int *dest, int *s1, int *s2, int L)
{
  int i;
  
  for(i = 0; i < L; i++)
    dest[i] = (s1[i] == 1 && s2[i] == 1 ? 1 : 0);
}

// read tree in (old) NCBI format
void ReadTreeNCBI(char *names, int *n, int *src, int *dest, int *nc, char *fstr)
{
  FILE *fp;
  int ref;
  int lastlevel[10000];
  char str[1000];
  int level;
  int i, j;
  FILE *fpout1, *fpout2;
 
  fp = fopen(fstr, "r");
  if(fp == NULL)
    {
      printf("Couldn't read common tree file %s\n", fstr);
      exit(0);
    }
  ref = 0; lastlevel[0] = 0;

  sprintf(str, "%s-labels", fstr);
  fpout1 = fopen(str, "w");
  sprintf(str, "%s-edges", fstr);
  fpout2 = fopen(str, "w");

  // level stores level in tree
  // assign the previous node at one higher level to be this node's parent

  while(!feof(fp))
    {
      // read line in file
      // get level as number of "+" characters
      fgets(str, 1000, fp);
      if(feof(fp)) break;
      ref++;
      level = 0;
      for(i = 0; str[i] == '+' || str[i] == ' '; i++) level += (str[i] == '+');

      // get name of node
      j = 0; for(; str[i] != '\n'; i++) names[ref*LEN+(j++)] = str[i];
      names[ref*LEN+j-1] = '\0';

      // construct links according to relative levels
      lastlevel[level] = ref;
      if(level > 0)
	{
	  dest[*nc] = ref;
	  src[*nc] = lastlevel[level-1];
	  (*nc)++;
	}
    }
  *n = ref;
  fclose(fp);

  // output names and connections
  for(i = 1; i < *n; i++)
    fprintf(fpout1, "%s\n", &names[LEN*i]);
  for(i = 0; i < *nc; i++)
    fprintf(fpout2, "%i %i\n", src[i], dest[i]);
  
  printf("%i nodes overall\n", *n);

  fclose(fpout1);
  fclose(fpout2);

  // output DOT format for plotting if required
  sprintf(str, "%s.dot", fstr);
  fpout1 = fopen(str, "w");
  fprintf(fpout1, "digraph D {\n  node [shape=plaintext]\n");
  for(i = 0; i < *nc; i++)
    fprintf(fpout1, "  \"%s\" -> \"%s\";\n", &names[LEN*src[i]], &names[LEN*dest[i]]);
  fprintf(fpout1, "}\n");
  fclose(fpout1);
}

// get names of species for which we have observations
void ReadSpecies(char *names, int *refs, int n, char *fstr)
{
  FILE *fp;
  int line;
  int i, j;
  int found;
  char str[200];
  int ancestor = 1;

  // now grab the leaf names and indexes from a separate file
  fp = fopen(fstr, "r");
  if(fp == NULL)
    {
      printf("Couldn't read species list %s\n", fstr);
      exit(0);
    }
  printf("I found the following indices in species file: (-1 = not found)\n");
  line = 0;
  for(i = 0; i < n; i++) refs[i] = -1;

  // look for species names in our tree
  while(!feof(fp))
    {
      fgets(str, 200, fp);
      if(feof(fp)) break;
      for(i = 0; i < 200; i++) str[i] = (str[i] == '\n' ? '\0' : str[i]);
      for(i = 0; i < n; i++)
	{
	  if(strcmp(str, &names[LEN*i]) == 0) refs[i] = line; 
	}
      line++;
    }
  for(i = 0; i < n; i++)
    {
      printf("%s %i\n", &names[LEN*i], refs[i]);
    }
  for(i = 0; i < line; i++)
    {
      found = 0;
      for(j = 0; j < n; j++)
	{
	  if(refs[j] == i) found = 1;
	}
      if(found == 0)
	{
	  printf("ALERT: Somehow, I don't have an entry for number %i\n", i);
	}
    }
  fclose(fp);
}

// read sets of observations corresponding to leaves on the tree
void ReadTraits(int *matrix, char *fstr, int *L, int n)
{
  FILE *fp;
  int line;
  int i;
  int count;
  char ch;
  
  // now grab the actual trait properties
  fp = fopen(fstr, "r");
  if(fp == NULL)
    {
      printf("Couldn't read trait file %s\n", fstr);
      exit(0);
    }

  // identify number of features
  count = 0;
  do{
    ch = fgetc(fp);
    if(ch >= '0' && ch <= '9') count++;
    if(ch == '\n' || feof(fp)) break;
  }while(ch != '\n' && !feof(fp));
  if(feof(fp))
    {
      printf("Couldn't make sense of trait file %s\n", fstr);
      exit(0);
    }
  else printf("I found %i traits\n", count);
  rewind(fp);

  // read in set of observations
  *L = count;
  line = 0;
  while(!feof(fp))
    {
      for(i = 0; i < *L; i++)
	fscanf(fp, "%i", &matrix[line*(*L)+i]);
      if(!feof(fp)) line++;
    }

  printf("I read %i lines and expected %i barcodes\n", line, n);
  fclose(fp);
}

int main(int argc, char *argv[])
{
  FILE *fp, *fp1;
  int change;
  int refs[10000];
  int line;
  char str[10000];
  int *matrix;
  int *traits;
  int foundtraits[10000];
  int cando;
  int *src, *dest;
  char *names;
  int n, nc;
  int i, j, k;
  int ref[1000], ref1, ref2, nref;
  int leaf;
  char fstr[200];
  int L;
  
  if(argc != 4)
    {
      printf("Usage: ./construct-barcodes.ce [species names] [traits] [common tree]\n");
      return 0;
    }

  // allocate memory for various structures
  matrix = (int*)malloc(sizeof(int)*10000*MAXL);
  traits = (int*)malloc(sizeof(int)*10000*MAXL);
  names = (char*)malloc(sizeof(char)*10000*LEN);
  src = (int*)malloc(sizeof(int)*1000000);
  dest = (int*)malloc(sizeof(int)*1000000);

  // read in tree structure, list of species, and feature lists
  ReadTreeNCBI(names, &n, src, dest, &nc, argv[3]);
  ReadSpecies(names, refs, n, argv[1]);
  ReadTraits(matrix, argv[2], &L, n);

  // identify leaves
  do{
    change = 0;
    for(j = 1; j < n; j++)
      {
	leaf = 1;
	for(i = 0; i < nc; i++)
	  {
	    if(src[i] == j) leaf = 0;
	  }
	if(leaf == 1 && refs[j] == -1)
	  {
	    for(i = 0; i < nc; i++)
	      {
		if(dest[i] == j)
		  {
		    for(k = i; k < nc-1; k++)
		      {
			src[i] = src[i+1];
			dest[i] = dest[i+1];
		      }
		    nc--;
		    change = 1;
		  }
	      }
	    printf("Couldn't find ref for %i %s, removed %i\n", j, &names[LEN*j], nc);
	  }
      }
  }while(change == 1);

  // assign traits to leaves
  for(i = 1; i < n; i++)
    foundtraits[i] = 0;
  for(i = 1; i < n; i++)
    {
      if(refs[i] != -1)
	{
	  printf("%s %i : ", &names[LEN*i], refs[i]);
	  for(j = 0; j < L; j++)
	    {
	      traits[L*i+j] = matrix[L*refs[i]+j];
	      if(traits[L*i+j] == 2) traits[L*i+j] = 1;
	      printf("%i ", traits[L*i+j]);
	    }
	  foundtraits[i] = 1;
	  printf("\n");
	}
    }

  // now (inefficiently -- except we're ordered in a fortuitous way) loop through the tree assigning traits to ancestors until we're all done
  do{
    change = 0;
    for(i = 1; i < n; i++)
      {
	if(foundtraits[i] == 0)
	  {
	    cando = 1; nref = 0;
	    for(j = 0; j < nc; j++)
	      {
		if(src[j] == i)
		  {
		    ref[nref] = dest[j];
		    if(foundtraits[ref[nref]] == 0) cando = 0;
		    nref++;
		  }
	      }
	    if(cando == 1)
	      {
		printf("%s = ", &names[LEN*i]);
		for(j = 0; j < nref; j++)
		  {
		    printf("%s u ", &names[LEN*ref[j]]);
		    if(j == 0)
		      {
			for(k = 0; k < L; k++)
			  traits[L*i+k] = traits[L*ref[j]+k];
		      }
		    else
		      {
			Construct(&traits[L*i], &traits[L*i], &traits[L*ref[j]], L);
		      }
		  }
		    for(k = 0; k < nref; k++)
		      {
			printf("\n" ); 
			for(j = 0; j < L; j++)
			  printf("%i ", traits[L*ref[k]+j]);
		      }
		printf("\n="); 
		for(j = 0; j < L; j++)
		  printf("%i ", traits[L*i+j]);
		printf("\n");
		foundtraits[i] = 1;
		change = 1;
	      }
	    else
	      printf("%s: can't do this one yet\n", &names[LEN*i]);
	  }
      }
  }while(change == 1);

  // output results
  sprintf(fstr, "%s-names.txt", argv[2]);
  fp1 = fopen(fstr, "w");
  for(i = 1; i < n; i++)
    fprintf(fp1, "%s\n", &names[LEN*i]);
  fclose(fp1);

  sprintf(fstr, "%s-traits.txt", argv[2]);
  fp1 = fopen(fstr, "w");
  for(i = 1; i < n; i++)
    {
      for(j = 0; j < L; j++)
	fprintf(fp1, "%i ", traits[L*i+j]);
      fprintf(fp1, "\n");
    }
  fclose(fp1);

  // finally, output the transitions observed
  sprintf(fstr, "%s-trans.txt", argv[2]);
  fp = fopen(fstr, "w");
  sprintf(fstr, "%s-changes.txt", argv[2]);
  fp1 = fopen(fstr, "w");
  int datacounter = 0;
  int flagprob;
  for(i = 0; i < nc; i++)
    {
      change = 0; ref1 = 0; ref2 = 0;
      for(j = 0; j < L; j++)
	{
	  ref1 += traits[L*src[i]+j];
	  ref2 += traits[L*dest[i]+j];
	  if(traits[L*src[i]+j] != traits[L*dest[i]+j]) change = 1;
	}
      if(change == 1)
	{
	  flagprob = 0;
	  fprintf(fp1, "%i %i %i %i\n", src[i], dest[i], ref1, ref2);
	  printf("Datapoint %i: Change from %s to %s\n", datacounter++, &names[LEN*src[i]], &names[LEN*dest[i]]);
	  for(j = 0; j < L; j++)
	    {
	    fprintf(fp, "%i ", traits[L*src[i]+j]);
	    printf("%i", traits[L*src[i]+j]);
	    }
	  fprintf(fp, "\n");
	  printf("\n");
	  for(j = 0; j < L; j++)
	    {
	    fprintf(fp, "%i ", traits[L*dest[i]+j]);
	    printf("%i", traits[L*dest[i]+j]);
	    if(traits[L*dest[i]+j] == 0 && traits[L*src[i]+j] == 1) flagprob = 1;
	    }
	  fprintf(fp, "\n");
	  if(flagprob) printf("\n**** !!!!!!!!");
	  printf("\n\n");
	}
    }
  fclose(fp);
  fclose(fp1);
  
  return 0;
}


