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
void selectionSort(HappyNumber arr[], int length);
void findHappy(HappyNumber arr[], long lower, long upper);
void printHappy(HappyNumber arr[]);
double findNorm(long number);
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
    // POST: Swaps the addresses of the array elements. 

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
    // PRE: Long is passed in as an argument. 
    // POST: Returns the squared sum of the digits of that long. 

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

void selectionSort(HappyNumber arr[], int length) {
    // PRE: Array is already filled with 10 elements.
    // POST: Sorts the array by descending norm in quadratic time. 

    // Since the array size is small, running in quadratic time should not matter. 
    int index = 0;
    int max = 0;
    int i;

    // Find the current min
    for (index; index < length; index++) {
        max = index;
        for (i = max + 1; i < length; i++) {
            if (arr[i].norm > arr[max].norm) {
                max = i;
            }
        }

        if (max != index) {
            swapElements(&arr[index], &arr[max]);
        }
    }
}

double findNorm(long number) {
    // PRE: The passed argument is a happy number. 
    // POST: Returns the norm of that happy number.

    if (number == 1) {
        return 1.0;
    } else {
        double total = 0.0;
        while (number != 1) {
            number = digitSum(number);
            total += number;
        }

        return sqrt(total);
    }
}

void findHappy(HappyNumber arr[], long lower, long upper) {
    // PRE: Upper and lower bounds have been established. 
    // POST: Keeps track of the 10 happy numbers with the highest norms. 

    int count = 0;
    for (lower; lower < upper; lower++) {
        if (isHappy(lower)) {
            double norm = findNorm(lower);
            HappyNumber new = {lower, norm};

            if (count < 10) {
                arr[count] = new;
                count++;
            } else if (count >= 10) {
                selectionSort(arr, 10);
                if (new.norm > arr[9].norm) {
                    swapElements(&new, &arr[9]);
                    selectionSort(arr, 10);
                }
            }
        }
    }

    /* Implemented to initialize remaining array elements in cases where
       a specified range has less than 10 happy numbers. */
    if (count < 10) {
        int i;
        HappyNumber *happyPtr = arr;
        for (i = count; i < 10; i++) {
            (happyPtr + i) -> value = 0;
            (happyPtr + i) -> norm = 0;
        }

        selectionSort(arr, count);
    }
}

void printHappy(HappyNumber arr[]) {
    // PRE: Array has already been sorted. 
    // POST: Outputs the value of non-zero structs in the array.

    int i;
    int notHappy = 0;
    HappyNumber *happyPtr = arr;
    for (i = 0; i < 10; i++) {
        if ((happyPtr + i) -> value != 0) {
            printf("%li\n", (happyPtr + i) -> value);
        } else {
            notHappy++;
        }
    }

    if (notHappy == 10) printf("NOBODY'S HAPPY :(\n");
}

int main() {
    // PRE: User input determines the bounds of calculations. 
    // POST: Outputs in descending order the norms of happy numbers that fall within specified bounds. 

    long lower = 0;
    long upper = 0;
    HappyNumber list[10];

    getArguments(&lower, &upper);
    if (lower > upper) swap(&lower, &upper);

    findHappy(list, lower, upper);
    printHappy(list);
    
    return 0;
}
