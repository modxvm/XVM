/**
 * XVM Native ping module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#include "ping.h"
#include "stdio.h"

int main()
{
    printf("IP addr 8.8.8.8: %d \n",ping("8.8.8.8"));
    printf("host google.com: %d \n",ping("google.com"));

    return 0;
}