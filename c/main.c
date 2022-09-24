/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Main Program in C
*/

#include <stdio.h>
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
void printHappy(HappyNumber arr[], int length);
double findNorm(long number);
long digitSum(long number);
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
long digitSum(long number) {
    // PRE: Long is passed in as an argument. 
    // POST: Returns the squared sum of the digits of that long. 

    int sum, digit;
    for (sum = 0; number != 0; number /= 10) {    // Stefan showed me this idea. 
        digit = number % 10;
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

    // Since the array size is small, running in quadratic time should be fine. 
    int current = 0;
    int max = 0;
    int next;

    for (current; current < length; current++) {
        max = current;
        for (next = max + 1; next < length; next++) {
            if (arr[next].norm > arr[max].norm) {
                max = next;
            }
        }

        if (max != current) {
            swapElements(&arr[current], &arr[max]);
        }
    }
}

double findNorm(long number) {
    // PRE: The passed argument is a happy number. 
    // POST: Returns the norm of that happy number.

    if (number == 1) {
        return 1.0;
    } else {
        double total = (number * number) + 1;
        int addend;
        while (number != 1) {
            addend = digitSum(number);
            total += (addend * addend);
            number = addend;
        }

        return sqrt(total);
    }
}

void findHappy(HappyNumber arr[], long lower, long upper) {
    // PRE: Upper and lower bounds have been established. 
    // POST: Ten happy numbers with the highest norms are contained.

    int count = 0;
    for (lower; lower <= upper; lower++) {
        if (isHappy(lower)) {
            double norm = findNorm(lower);
            HappyNumber new = {lower, norm};

            if (count < 10) {
                arr[count] = new;
                count++;
            } else if (count == 10) {
                selectionSort(arr, 10);

                /* In cases where there are more than 10 happy numbers in a given
                   range, this helps to push out the minimum value and keep track
                   of the happy numbers with the largest norms. */

                if (new.norm > arr[9].norm) {
                    arr[9].value = new.value;
                    arr[9].norm = new.norm;
                    selectionSort(arr, 10);
                }
            }
        }
    }

    /* Implemented to initialize remaining empty elements in cases where
       a specified range has less than 10 happy numbers. */
    if (count < 10) {
        int index;
        HappyNumber *happyPtr = arr;
        for (index = count; index < 10; index++) {
            (happyPtr + index) -> value = 0;
            (happyPtr + index) -> norm = 0;
        }

        selectionSort(arr, count);
    }
}

void printHappy(HappyNumber arr[], int length) {
    // PRE: Array has already been sorted. 
    // POST: Outputs the value of non-zero structs in the array.

    int index;
    int notHappy = 0;   
    HappyNumber *happyPtr = arr;
    for (index = 0; index < length; index++) {
        if ((happyPtr + index) -> value != 0) {
            printf("%li\n", (happyPtr + index) -> value);
        } else {
            notHappy++;     // Used in cases where there are no happy numbers in range.
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
    printHappy(list, 10);
    
    return 0;
}
