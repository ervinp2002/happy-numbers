package main

import "fmt"
import "math"





func main() {
	// POST:

	var happynums map[float32]int
	var lower int
	var upper int

	fmt.Printf("First Argument: ")
	fmt.Scanln(&lower)

	fmt.Printf("Second Argument: ")
	fmt.Scanln(&upper)

	if lower > upper {
		temp = lower
		lower = upper
		upper = lower
	}

	// Step 2: Find happy numbers in range
	// Step 3: For every happy number, find its norm
	// Step 4: Push out minimum-norm pair if the map length is 10 or higher
	// Step 5: Sort after iterating through the range
	// Step 6: Output the 10 happy numbers with highest norms in descending order

}

