
#include "libasm.h"
#include <stdio.h>
#include <string.h>

void test_ft_strlen() 
{
    char *str1 = "Hello, World!";
    char *str2 = "Libasm is great!";
    char *str3 = "";

    printf("\nTesting ft_strlen:\n");
    printf("Length of '%s' output %lu | correct_output %lu \n", str1, ft_strlen(str1), strlen(str1));
    printf("Length of '%s' output %lu | correct_output %lu \n", str2, ft_strlen(str2), strlen(str2));
    printf("Length of '%s' output %lu | correct_output %lu \n", str3, ft_strlen(str3), strlen(str3));
}

void test_ft_strcpy() 
{
    char src1[] = "Hello, World!";
    char dest1[50];
    char src2[] = "Libasm is great!";
    char dest2[50];
    char src3[] = "";
    char dest3[50];

    printf("\nTesting ft_strcpy:\n");
    printf("Copying '%s' to dest1: '%s'\n", src1, ft_strcpy(dest1, src1));
    printf("Copying '%s' to dest2: '%s'\n", src2, ft_strcpy(dest2, src2));
    printf("Copying '%s' to dest3: '%s'\n", src3, ft_strcpy(dest3, src3));
}

void test_ft_strcmp() 
{
    char *str1 = "Hello";
    char *str2 = "Helloo";
    char *str3 = "World";
    char *str4 = "";

    printf("\nTesting ft_strcmp:\n");
    printf("Comparing '%s' and '%s': %d | correct_output: %d\n", str1, str2, ft_strcmp(str1, str2), strcmp(str1, str2));
    printf("Comparing '%s' and '%s': %d | correct_output: %d\n", str1, str3, ft_strcmp(str1, str3), strcmp(str1, str3));
    printf("Comparing '%s' and '%s': %d | correct_output: %d\n", str1, str4, ft_strcmp(str1, str4), strcmp(str1, str4));
}

int main() 
{
    test_ft_strlen();
    test_ft_strcpy();
    test_ft_strcmp();
    
}



