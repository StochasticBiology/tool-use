// this code builds the set of HyperTraPS transitions for a given phylogeny
// we use an old-format NCBI text tree (can be obtained from a modern one with accompanying script), a list of species of interest, and a corresponding list of traits
// we use maximum parsimony to estimate ancestral node states, and hence build the list of transitions that have occurred from ancestor to descendant down the tree

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define LEN 200
#define MAXL 1000

void Construct(int *dest, int *s1, int *s2, int L)
{
  int i;
  
  for(i = 0; i < L; i++)
    dest[i] = (s1[i] == 1 && s2[i] == 1 ? 1 : 0);
}

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
      fgets(str, 1000, fp);
      if(feof(fp)) break;
      ref++;
      level = 0;
      for(i = 0; str[i] == '+' || str[i] == ' '; i++) level += (str[i] == '+');
      j = 0; for(; str[i] != '\n'; i++) names[ref*LEN+(j++)] = str[i];
      names[ref*LEN+j-1] = '\0';
      //  fprintf(fp2, "%i %i %s", ref, level, &str[i]);
      lastlevel[level] = ref;
      if(level > 0)
	{
	  dest[*nc] = ref;
	  src[*nc] = lastlevel[level-1];
	  (*nc)++;
	  //  fprintf(fp1, "%i %i\n", ref, lastlevel[level-1]);
	}
    }
  *n = ref;
  fclose(fp);
  //  fclose(fp1);
  //fclose(fp2);
  // output

  for(i = 1; i < *n; i++)
    fprintf(fpout1, "%s\n", &names[LEN*i]);
  for(i = 0; i < *nc; i++)
    fprintf(fpout2, "%i %i\n", src[i], dest[i]);
  
  printf("%i nodes overall\n", *n);

  fclose(fpout1);
  fclose(fpout2);

  sprintf(str, "%s.dot", fstr);
  fpout1 = fopen(str, "w");
  fprintf(fpout1, "digraph D {\n  node [shape=plaintext]\n");
  for(i = 0; i < *nc; i++)
    fprintf(fpout1, "  \"%s\" -> \"%s\";\n", &names[LEN*src[i]], &names[LEN*dest[i]]);
  fprintf(fpout1, "}\n");
  fclose(fpout1);
}

void ReadTreeNewick(char *names, int *n, int *src, int *dest, int *nc, char *fstr)
{
  int i, j, k; 
  int start, end;
  char str1[10000], str2[10000];
  char ch;
  int len;
  int gap;
  int ref, ref1, ref2;
  FILE *fp;
  char tree[10000];

  // first read newick tree as string
  fp = fopen(fstr, "r");
  len = 0;
  do{
    ch = fgetc(fp);
    if(!feof(fp)) tree[len++] = ch;
  }while(!feof(fp));
  tree[len-1] = '\0';
  fclose(fp);

  // parse newick tree. from start to end, when a close-paren is encountered, back up to the preceding opener, store both names and their relationship, create a new node that is their ancestor, and replace the (..,..) identified with that node
  printf("%s\n", tree); 
  *n = 1; *nc = 0;
  for(i = 0; tree[i] != '\0'; i++)
    {
      if(tree[i] == ')')
	{
	  end = i;
	  for(j = i; tree[j] != '(' && j != 0; j--); start = j;
	  k = 0; if(tree[j] == '(') j++; for(; tree[j] != ','; j++) str1[k++] = tree[j]; str1[k] = '\0';
	  k = 0; j++; for(; tree[j] != ')'; j++) str2[k++] = tree[j]; str2[k] = '\0';
	  if(atoi(str1) != 0) ref1 = atoi(str1); else 
	    { sprintf(&names[LEN*(*n)], "%s", str1); (*n)++; ref1 = *n-1; }
	  if(atoi(str2) != 0) ref2 = atoi(str2); else 
	    { sprintf(&names[LEN*(*n)], "%s", str2); (*n)++; ref2 = *n-1; }
	  sprintf(&names[LEN*(*n)], "%i", *n); (*n)++;
	  src[*nc] = *n-1; dest[*nc] = ref1; (*nc)++;
	  src[*nc] = *n-1; dest[*nc] = ref2; (*nc)++;
	  sprintf(&tree[start], "%s", &names[LEN*(*n-1)]);
	  gap = (end-start)-strlen(&names[LEN*(*n-1)]);
	  for(k = start+strlen(&names[LEN*(*n-1)]); tree[k+gap] != '\0'; k++)
	    tree[k] = tree[k+gap+1];
	  tree[k] = '\0';
	  printf("%s\n", tree); 
	  i -= gap+1;
	  for(j = 0; j < i; j++) printf(" ");
	  printf("^\n");
	}
    }

  // output
  printf("\n{");
  for(i = 1; i < *n; i++)
    printf("\"%s\", ", &names[LEN*i]);
  printf("}\n");
  for(i = 0; i < *nc; i++)
    printf("%i -> %i, ", src[i], dest[i]);
}

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
      //if(refs[i] == -1) sprintf(&names[LEN*i], "%i", ancestor++);
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
  
  matrix = (int*)malloc(sizeof(int)*10000*MAXL);
  traits = (int*)malloc(sizeof(int)*10000*MAXL);
  names = (char*)malloc(sizeof(char)*10000*LEN);
  src = (int*)malloc(sizeof(int)*1000000);
  dest = (int*)malloc(sizeof(int)*1000000);

  ReadTreeNCBI(names, &n, src, dest, &nc, argv[3]);
  ReadSpecies(names, refs, n, argv[1]);
  ReadTraits(matrix, argv[2], &L, n);
  
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
	  fprintf(fp1, "%i %i %i %i\n", src[i], dest[i], ref1, ref2);
	  //  printf("Change from %s to %s\n", &names[LEN*src[i]], &names[LEN*dest[i]]);
	  for(j = 0; j < L; j++)
	    fprintf(fp, "%i ", traits[L*src[i]+j]);
	  fprintf(fp, "\n");
	  for(j = 0; j < L; j++)
	    fprintf(fp, "%i ", traits[L*dest[i]+j]);
	  fprintf(fp, "\n");
	}
    }
  fclose(fp);
  fclose(fp1);
  
  return 0;
}


