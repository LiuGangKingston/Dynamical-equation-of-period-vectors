#include "acceleration.h"
#include <stdio.h>
#include <malloc.h>


int main(argc,argv)
int argc;
char *argv[];
{
 double * mass, * period, * in_s, * ex_s, *  acct;
 int i, j, k;
 
 mass = (double*) malloc(3*sizeof(double));
 period = (double*) malloc(9*sizeof(double));
 in_s = (double*) malloc(9*sizeof(double));
 ex_s = (double*) malloc(9*sizeof(double));
 acct = (double*) malloc(9*sizeof(double));

 for(i=0;i<9;i++) {
     period[i]=0.0e0;
     in_s[i]=0.0e0;
     ex_s[i]=0.0e0;
     acct[i]=0.0e0;
    }
 mass[0]=1.0e0;
 mass[1]=2.0e0;
 mass[2]=4.0e0;

 period[0]=1.0e0;
 period[4]=2.0e0;
 period[8]=3.0e0;

 in_s[0]=14.0e0;
 in_s[4]=15.0e0;
 in_s[8]=16.0e0;

 Acceleration_of_PERIODS( mass, period, in_s, ex_s, acct);

 printf( "acct = \n") ;
 for(i=0;i<3;i++) {
     printf( " %f, %f, %f \n", acct[i*3],acct[i*3+1],acct[i*3+2]) ;
    }

 return(0) ;
}



