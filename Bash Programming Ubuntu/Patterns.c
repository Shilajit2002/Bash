#include<stdio.h>
#include<math.h>

int main()
{
    int i,j,n;
    printf("Enter the no of terms : ");
    scanf("%d",&n);
    printf("<---First Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=i;j++)
        {
            printf("*");
        }
        printf("\n");
    }
    printf("<---Second Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=n;j>=i;j--)
        {
            printf("*");
        }
        printf("\n");
    }
    printf("<---Third Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=i;j++)
        {
            printf("%d",j);
        }
        printf("\n");

    }
    printf("<---Fourth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=n;j++)
        {
            if((i+j)<=n)
                printf(" ");
            else
                printf("*");
        }
        printf("\n");
    }
    printf("<---Fifth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=n;j++)
        {
            if((i-j)>=1)
                printf(" ");
            else
                printf("*");
        }
        printf("\n");
    }
    printf("<---Sixth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=i;j++)
        {
            printf("%d",i);
        }
        printf("\n");
    }
    printf("<---Seventh Pattern--->\n");
    int number=1;
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=i;j++)
        {
            printf("%d",number++);
        }
        printf("\n");
    }
    printf("<---Eighth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(int space=1;space<=(n-i);space++)
        {
            printf(" ");
        }
        for(j=1;j<=i;j++)
        {
            printf("* ");
        }
        printf("\n");
    }
    printf("<---Ninth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(int space=1;space<=(n-i);space++)
        {
            printf(" ");
        }
        for(j=1;j<=(2*i)-1;j++)
        {
            printf("*");
        }
        printf("\n");
    }
    printf("<---Tenth Pattern--->\n");
    for(i=n;i>=1;i--)
    {
        for(int space=1;space<=(n-i);space++)
        {
            printf(" ");
        }
        for(j=1;j<=(2*i)-1;j++)
        {
            printf("*");
        }
        printf("\n");
    }
    printf("<---Eleventh Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(int space=1;space<=(n-i);space++)
        {
            printf(" ");
        }
        for(j=1;j<=(2*i)-1;j++)
        {
            printf("*");
        }
        printf("\n");
    }
    for(i=n-1;i>=1;i--)
    {
        for(int space=1;space<=(n-i);space++)
        {
            printf(" ");
        }
        for(j=1;j<=(2*i)-1;j++)
        {
            printf("*");
        }
        printf("\n");
    }
    printf("<---Twelveth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=i;j++)
        {
            printf("*");
        }
        printf("\n");
    }
    for(i=1;i<=n-1;i++)
    {
        for(j=n-1;j>=i;j--)
        {
            printf("*");
        }
        printf("\n");
    }
    printf("<---Thirteenth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=i;j++)
        {
            printf("%c",64+j);
        }
        printf("\n");
    }
    printf("<---Fourteenth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=i;j++)
        {
            printf("%c",64+i);
        }
        printf("\n");
    }
    printf("<---Fifteenth Pattern--->\n");
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=n;j++)
        {
            if((i+j)<=n)
                printf(" ");
            else
                printf("*");
        }
        printf("\n");
    }
    for(i=1;i<=n;i++)
    {
        for(j=1;j<=n;j++)
        {
            if((i-j)>=0)
                printf(" ");
            else
                printf("*");
        }
        printf("\n");
    }
    printf("<---Sixteenth Pattern--->\n");
    for(i=1;i<n;i++)
    {
        for(j=1;j<n*2;j++)
        {
            if((j-i)>=1 && (j+i)<n*2)
            {
                printf(" ");
            }
            else
                printf("*");
        }
        printf("\n");
    }
    for(i=1;i<n*2;i++)
    {
        printf("*");
    }
    printf("\n");
    for(i=n-1;i>=1;i--)
    {
        for(j=1;j<n*2;j++)
        {
            if((j-i)>=1 && (j+i)<n*2)
            {
                printf(" ");
            }
            else
                printf("*");
        }
        printf("\n");
    }
    printf("<---Heart Pattern--->\n");
    for(i=n/2; i<=n; i+=2)
    {
        for(j=1; j<n-i; j+=2)
        {
            printf(" ");
        }

        for(j=1; j<=i; j++)
        {
            printf("*");
        }

        for(j=1; j<=n-i; j++)
        {
            printf(" ");
        }

        for(j=1; j<=i; j++)
        {
            printf("*");
        }

        printf("\n");
    }

    for(i=n; i>=1; i--)
    {
        for(j=i; j<n; j++)
        {
            printf(" ");
        }

        for(j=1; j<=(i*2)-1; j++)
        {
            printf("*");
        }

        printf("\n");
    }
}