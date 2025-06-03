
#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

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

void test_ft_write() 
{
    const char *message = "Hello, World!\n";
    printf("\nTesting ft_write:\n");
    ssize_t result = ft_write(1, message, 14); // 14 is the length of the message including newline
    printf("ft_write returned: %zd | correct_output: %zd\n", result, write(1, message, 14));
    // Check if errno is set when ft_write fails
    ssize_t error = ft_write(-1, message, 14); // Intentionally passing an invalid file descriptor
    if (error == -1) {
        perror("ft_write failed");
    }
    
}

void test_ft_read() 
{
    char buffer[50];
    printf("\nTesting ft_read:\n");
    ssize_t result = ft_read(0, buffer, 50); // Read from standard input
    
    if (result >= 0) {
        buffer[result] = '\0'; // Null-terminate the string
        printf("ft_read returned: %zd | Read content: %s\n", result, buffer);
    }
    result = ft_read(-1, buffer, 50); // Read from standard input

    if (result == -1) {
        perror("ft_read failed");
    }
}

void test_ft_strdup() 
{
    char *str1 = "Hello, World!";
    char *str2 = "Libasm is great!";
    char *str3 = "";

    printf("\nTesting ft_strdup:\n");
    char *dup1 = ft_strdup(str1);
    char *dup2 = ft_strdup(str2);
    char *dup3 = ft_strdup(str3);

    printf("Duplicate of '%s': '%s' | correct_output: '%s'\n", str1, dup1, strdup(str1));
    printf("Duplicate of '%s': '%s' | correct_output: '%s'\n", str2, dup2, strdup(str2));
    printf("Duplicate of '%s': '%s' | correct_output: '%s'\n", str3, dup3, strdup(str3));

    // Free the duplicated strings
    free(dup1);
    free(dup2);
    free(dup3);
}

int main() 
{
    test_ft_strlen();
    test_ft_strcpy();
    test_ft_strcmp();
    test_ft_write();
    test_ft_read();
    test_ft_strdup();
    
}



