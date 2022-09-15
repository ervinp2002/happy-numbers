/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Main Program in C
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>

typedef struct {
    long value;
    double norm;
} HappyNumber;

void swap(long *arg1, long *arg2);
void swapElements(HappyNumber *arg1, HappyNumber *arg2);
void getArguments(long *lower, long *upper);
void bubbleSort(HappyNumber arr[]);
long digitSum(long n);
bool isHappy(long number);

void swap(long *arg1, long *arg2) {
    // PRE: Two variables are initialized and their addresses are passed in. 
    // POST: Swaps the addresses of the arguments. 

    long temp = *arg1;
    *arg1 = *arg2;
    *arg2 = temp;
}

void swapElements(HappyNumber *arg1, HappyNumber *arg2) {
    // PRE: Passed arguments are array elements. 
    // POST: 

    HappyNumber temp = *arg1;
    *arg1 = *arg2;
    *arg2 = temp;
}

void getArguments(long *lower, long *upper) {
    // PRE: Two pointers are passed as arguments. 
    // POST: Saves user input as upper and lower bounds. 

    printf("First Argument: ");
    scanf(" %li", lower);

    // Prevents 0 and negative numbers from being recorded. 
    while (lower <= 0 || lower == NULL) { 
        if (lower == NULL) fflush(stdin);                  
        printf("\nFirst Argument: ");
        scanf(" %li", lower);
    }

    printf("Second Argument: ");
    scanf(" %li", upper);

    // Prevents 0, negative numbers, and duplicate lower value from being recorded. 
    while (upper <= 0 || lower == upper || upper == NULL) {
        if (upper == NULL) fflush(stdin);
        printf("\nSecond Argument: ");
        scanf(" %li", upper);     
    }
}

// Function modified from Rosetta Code version. 
long digitSum(long n) {
    // PRE:
    // POST:

    int sum, digit;
    for (sum = 0; n != 0; n /= 10) {    // Stefan showed me this idea. 
        digit = n % 10;
        sum += digit * digit;
    }

    return sum;
}

bool isHappy(long number) {
    // PRE: Bounds to find happy numbers have already been established. 
    // POST: Returns true or false if the passed argument is happy. 

    while (number != 1 && number != 4) {    // 4 will always start a cycle leading to an unhappy number. 
        number = digitSum(number);
    }

    return number == 1 ? true : false;
}

void bubbleSort(HappyNumber arr[]) {
    // PRE: Array is already filled with 10 elements.
    // POST: Sorts the array by descending norm in quadratic time. 

    bool sorted = false;
    int size = sizeof(arr) / sizeof(HappyNumber);
    while (!sorted) {
        for (int i = 0; i < size; i++) {
            for (int j = 1; i < size; j++) {
                if (arr[i].norm < arr[j].norm) {
                    swapElements(&arr[i], &arr[j]);
                }
            }
        }
    }
}

int main() {
    // PRE: User input determines the bounds of calculations. 
    // POST: Outputs in descending order the norms of happy numbers that fall within specified bounds. 

    long lower = 0;
    long upper = 0;
    HappyNumber list[10];

    getArguments(&lower, &upper);
    if (lower > upper) swap(&lower, &upper);

    printf("Lower is: %li\n", lower);
    printf("Upper is: %li\n", upper);

    

    return 0;
}
