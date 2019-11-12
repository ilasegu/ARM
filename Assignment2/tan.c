#include <stdio.h>
# define pi 3.14159
int main()
{
    double deg;
   double x;
	deg=45;
	x=(pi/180)*deg;
	printf("Deg=%f in Rad=%f",deg,x);
	double s,c,t1,t2,res;;
	c=1;t1=1;
	s=x;t2=x;
	int fact=1,i=1,n=10;
	while(i<n)
	{
		t1*=(x*x);
		t2*=(x*x);
		fact*=(2*i);
		t1/=fact;
		fact*=((2*i)+1);
		t2/=fact;
		if(i%2==1)
		{
			c-=t1;
			s-=t2;
		}
         else
		 {
			   c+=t1;
			   s+=t2;
		 }
		 i=i+1;
	
	}
	res=s/c;
    printf("value for tan %f =%f",x,res);    return 0;
}