#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int addstr(char *a, char *b);
extern int is_palindrome(char *s);
extern int factstr(char *s);
extern void palindrome_check();

int fact(int n) {
    if (n <= 1) return 1;
    return n * fact(n - 1);
}

int main() {
    int choice;
    int result = 0;
    char input1[100], input2[100];

    while (1) {
        printf("\n1) Add two numbers together\n");
        printf("2) Test if a string is a palindrome (C -> ASM)\n");
        printf("3) Print the factorial of a number\n");
        printf("4) Test if a string is a palindrome (ASM -> C)\n");
        printf("Enter choice: ");

        if (scanf("%d", &choice) != 1) {
            fprintf(stderr, "Invalid input. Exiting.\n");
            break;
        }
        getchar(); // consume newline

        switch(choice) {
            case 1:
                printf("Enter first number: ");
                if (!fgets(input1, sizeof(input1), stdin)) { break; }
                input1[strcspn(input1, "\n")] = 0;

                printf("Enter second number: ");
                if (!fgets(input2, sizeof(input2), stdin)) { break; }
                input2[strcspn(input2, "\n")] = 0;

                result = addstr(input1, input2);
                printf("Sum is: %d\n", result);
                break;

            case 2:
                printf("Enter string: ");
                if (!fgets(input1, sizeof(input1), stdin)) { break; }
                input1[strcspn(input1, "\n")] = 0;

                result = is_palindrome(input1);
                printf("Palindrome? %s\n", result ? "Yes" : "No");
                break;

            case 3:
                printf("Enter number: ");
                if (!fgets(input1, sizeof(input1), stdin)) { break; }
                input1[strcspn(input1, "\n")] = 0;
                printf("Factorial is: %d\n", factstr(input1));
                break;

            case 4:
                palindrome_check();
                break;

            default:
                printf("Invalid option\n");
        }
    }

    return 0;
}
