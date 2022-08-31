/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Driver Program in C
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Following 3 lines were pulled from Rosetta Code. 
#define CACHE 256
enum { h_unknown = 0, h_yes, h_no };
unsigned char buf[CACHE] = {0, h_yes, 0};

typedef struct {
    long value;
    double norm;
} HappyNumber;

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

// Function pulled from Rosetta Code. 
int happy(int n) {
    // PRE:
    // POST: 

	int sum = 0, x, nn;
	if (n < CACHE) {
		if (buf[n]) return 2 - buf[n];
		buf[n] = h_no;
	}

	for (nn = n; nn; nn /= 10) x = nn % 10, sum += x * x;
	x = happy(sum);
	if (n < CACHE) buf[n] = 2 - x;

	return x;
}

int main() {
    // PRE: User input determines the bounds of calculations. 
    // POST: Outputs in descending order the norms of happy numbers that fall within specified bounds. 

    long lower = 0;
    long upper = 0;
    HappyNumber list[10];

    getArguments(&lower, &upper);
    if (lower > upper) swap(&lower, &upper);

    

    return 0;
}

  