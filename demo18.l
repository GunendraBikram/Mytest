%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
void addtokens(char *, int );
int linenumber=1;
int tokencount=0;
int lcount=0;
struct token{
char tokenname[50];
char linenumber[50];
};
struct token tokenlist[100];
%}
%%
\n {linenumber++;}
\;(.*) {};
[a-zA-Z]* {addtokens(yytext, linenumber);}

. ;
%%
int yywrap(void){}
void showtokens();
void main()
{

FILE *fp1;
fp1=fopen("Input.c","r");
yyin=fp1;
yylex();
showtokens();

}
void addtokens(char *str, int linenumber)
{

	char lno[100];
		
	tokencount++;
	strcpy(tokenlist[tokencount].tokenname,str);
	//tokenlist[tokencount].linenumber=linenumber;
	sprintf(lno,"%d",linenumber);
	strcpy(tokenlist[tokencount].linenumber,lno);	
	//printf("\n%s\t%s",tokenlist[tokencount].tokenname,tokenlist[tokencount].linenumber);
	
}
void showtokens()
{
	int i,j,count;
	int freq[100];
	char lineno[100];
	//printf("\nTotal tokens: \t%d",tokencount);
	
	
	for(i=1;i<=tokencount;i++)freq[i]=-1;
	for(i=1;i<=tokencount;i++)
	{
		count=1;
		strcpy(lineno, "");
		for(j=i+1;j<=tokencount;j++)
		{	
			
			if(strcmp(tokenlist[i].tokenname,tokenlist[j].tokenname)==0)
			{count++; freq[j]=0;strcat(lineno," ");strcat(lineno,tokenlist[j].linenumber);}
		
		}
	if(freq[i]!=0)
	{freq[i]=count;strcat(tokenlist[i].linenumber,lineno);}

	}
	for(i=1;i<=tokencount;i++)
	if(freq[i]!=0)
	printf("\n%s:\t  %s",tokenlist[i].tokenname, tokenlist[i].linenumber );
	

}		
	

