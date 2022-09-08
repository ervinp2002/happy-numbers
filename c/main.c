/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Driver Program in C
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    long value;
    double norm;
} HappyNumber;

int dsum(int n);
int happy(int n);

void swap(long *arg1, long *arg2);
void arraySwap(HappyNumber *value1, HappyNumber *value2);
void getArguments(long *lower, long *upper);

void quicksort(HappyNumber arr[], int first, int last);
void pincer(HappyNumber arr[], int first, int last, int *split);

void pincer(HappyNumber arr[], int first, int last, int *split) {
    // PRE: Called during a quicksort. 
    // POST: Moves all values less than pivot to the right and greater to the left. 

    int pivot = first;
    int saveFirst = first;		
    first++;

    while (first <= last) {
        while ((arr[first].norm <= arr[pivot].norm) && (first <= last)) last--;
        while ((arr[last].norm >= arr[pivot].norm) && (first <= last)) first++;  
        if (first < last) {
            arraySwap(&arr[first], &arr[last]);
            first++;	
            last--;
        }
    }

    split = last;
    arraySwap(&arr[saveFirst], &arr[*split]); 
}

void swap(long *arg1, long *arg2) {
    // PRE: Two pointers are passed as arguments. 
    // POST: Swaps the addresses of the arguments. 

    long temp = *arg1;
    *arg1 = *arg2;
    *arg2 = temp;
}

// Overloaded Swap Function. 
void arraySwap(HappyNumber *value1, HappyNumber *value2) {
    // PRE: Happy Numbers that are in the array are passed as arguments. 
    // POST: Swaps array elements. 

    HappyNumber temp = *value1;
    *value1 = *value2;
    *value2 = temp;
}

void quicksort(HappyNumber arr[], int first, int last) {
    // PRE: Array of happy numbers, with first and last index are passed in.
    // POST: Recursively sorts the array by descending norms. 

    if (first < last) {
        int splitPoint;
        pincer(arr, first, last, splitPoint);
        quicksort(arr, first, splitPoint - 1);
        quicksort(arr, splitPoint + 1, last);
    }
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

// Following 2 functions pulled from Rosetta Code.
int dsum(int n) {
    // PRE: Integer is passed as an argument. 
    // POST: Returns the sum of the square of each digit. 

    int sum, x;
    for (sum = 0; n; n /= 10) x = n % 10, sum += x * x;
	return sum;
}

// Pulled from Rosetta Code. 
int happy(int n) {
    // PRE: Integer is passed as an argument. 
    // POST: Returns a 1 if argument is happy, otherwise 0.

    int nn;
	while (n > 999) n = dsum(n);    // 4 digit numbers can't cycle. 
	nn = dsum(n);
	while (nn != n && nn != 1) 
        n = dsum(n), nn = dsum(dsum(nn));    // Cycle detection. 
	return n == 1;
}

int main() {
    // PRE: User input determines the bounds of calculations. 
    // POST: Outputs in descending order the norms of happy numbers that fall within specified bounds. 

    long lower = 0;
    long upper = 0;
    HappyNumber list[10];

    getArguments(&lower, &upper);
    if (lower > upper) swap(&lower, &upper);

    int result = happy(10);
    printf("%d\n", result);
    

    return 0;
}
