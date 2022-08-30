/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Driver Program in C
*/

#include <stdio.h>
#include <stdlib.h>

// Following 3 lines were pulled from Rosetta Code. 
#define CACHE 256
enum { h_unknown = 0, h_yes, h_no };
unsigned char buf[CACHE] = {0, h_yes, 0};

void swap(long *arg1, long *arg2);
void getArguments(long *lower, long *upper);
int happy(int n);

struct HappyNumber {
    long value;
    double norm;
};

void swap(long *arg1, long *arg2) {
    // PRE: Two pointers are passed as arguments. 
    // POST: Swaps the addresses of the arguments. 

    long temp = *arg1;
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
    
    getArguments(&lower, &upper);
    if (lower > upper) swap(&lower, &upper);

    

    return 0;
}

  