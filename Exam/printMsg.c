
#include "stm32f4xx.h"
#include <string.h>
void printMsg(const int a)
{
	 char Msg[100];
	 char *ptr;
	 // Printing the message
	
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 //Printing the first parameter
	 sprintf(Msg, "%d \n", a);
	// sprintf(Msg,"\n ");
}
void printMsg3p(const int a, const int b,const int c)
{
	
	 char Msg[100];
	 char *ptr;
	 // Printing the message
	sprintf(Msg,"\nPrinting  deg:  ");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 //Printing the first parameter
	 sprintf(Msg, "%d", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg," For  x: ");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 sprintf(Msg, "%d", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	  sprintf(Msg," And y : ");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 sprintf(Msg, "%d", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

void printMsg4p(const int a, const int b, const int c, const int d, const int e)
{
	 char Msg[100];
	 char *ptr;
	 // Printing the message
	sprintf(Msg,"\nPrinting First parameter a:  ");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 //Printing the first parameter
	 sprintf(Msg, "%x", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg,"\nPrinting Second parameter b: ");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 sprintf(Msg, "%x", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg,"\nPrinting Third parameter c: ");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 sprintf(Msg, "%x", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg,"\nPrinting Four parameter d: ");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 sprintf(Msg, "%x", d);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
	 }

	 // Printing the message
	 sprintf(Msg,"\nPrinting Fifth parameter e (check this value is correct or not): ");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }

	  sprintf(Msg, "%x", e);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

