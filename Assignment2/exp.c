#include <stdio.h>

int main()
{
    int i=1;
    double sum=1;
    int fact=1;
    double t=1,t1=1;
    double x=20;
    int n=10;
    while(i<n)
    {
       t=t*x;
        t/=i;
        sum+=t;
        i++;
        
    }
    printf("value for exp %f =%f",x,sum);    return 0;
}