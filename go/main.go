/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Main Program in Go
*/

package main

import (
	"fmt"
	"math"
	"sort"
)

func swap(arg1 *int, arg2 *int) {
	// PRE: Addresses passed in have initialized values.
	// POST: Swaps the addresses of the passed arguments. 

	temp := *arg1
	*arg1 = *arg2
	*arg2 = temp
}

func digitSum(number int) int {
	// PRE: An integer is passed in as a argument. 
	// POST: Returns the squared digit sum of the argument. 

	var sum, digit int = 0, 0
	for sum = 0; number != 0; number /= 10 {
		digit = number % 10
		sum += digit * digit
	}

	return sum
}

func isHappy(number int) bool {
	// PRE: Argument passed in is within the bounds of the input range. 
	// POST: Boolean value determines if the number is happy or not. 

	/* Determining if a number is happy uses the same methodology as
	   the C and Fortran implementations. */ 
	for number != 1 && number != 4 {
		number = digitSum(number)
	}

	if number == 4 {
		return false
	} else {
		return true
	}
}

func findNorm(number int) float64 {
	// PRE: Argument passed in has already been verified as a happy number. 
	// POST: Returns the norm of that happy number. 

	var total float64 = 0
	if number == 1 {
		return 1.0
	} else {
		total = math.Pow(float64(number), 2) + 1
		for number != 1 {
			nextNumber := digitSum(number)
			total += math.Pow(float64(nextNumber), 2)
			number = nextNumber
		}

		return math.Sqrt(total)
	}	
}

func findHappy(list map[float64]int, lower int, upper int) {
	// PRE: Map to hold pairs, upper, and lower bounds have been declared.
	// POST: Adds happy numbers and their norms to the map. 

	for i := lower; lower <= upper; i++ {
		if isHappy(i) {
			norm := findNorm(i)
			list[norm] = i
		}
	}
}

func printResults(list map[float64]int, normsList []float64) {
	// PRE: Map is filled and separate list for norms is already sorted. 
	// POST: Outputs the happy numbers with the highest norms. 

	var limit int
	if len(list) >= 10 {
		limit = 10
	} else {
		limit = len(list)
	}

	for i := 0; i < limit; i++ {
		fmt.Println(list[normsList[i]])
	}
}

func main() {
	/* POST: Outputs the 10 happy numbers with highest norms 
		     within the user-inputted range. */ 

	var happyNums = make(map[float64]int)
	var lower int
	var upper int

	fmt.Printf("First Argument: ")
	fmt.Scanln(&lower)

	fmt.Printf("Second Argument: ")
	fmt.Scanln(&upper)

	if lower > upper {
		swap(&lower, &upper)
	}

	findHappy(happyNums, lower, upper)

	// Referred to GeekForGeeks for sorting by keys. 
	norms := make([]float64, len(happyNums))
 	for key := range happyNums {
		norms = append(norms, key)
	}
	sort.Sort(sort.Reverse(sort.Float64Slice(norms)))

	printResults(happyNums, norms)
}
