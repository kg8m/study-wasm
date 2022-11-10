package main

import (
	"fmt"
	"math"
)

func isPrime(number int) bool {
	if number <= 1 {
		return false
	} else if number == 2 {
		return true
	} else if number%2 == 0 {
		return false
	}

	loop_limit := int(math.Floor(math.Sqrt(float64(number))))

	for i := 3; i <= loop_limit; i++ {
		if number%i == 0 {
			return false
		}
	}

	return true
}

func main() {
	for i := 1; i <= 500000; i++ {
		if isPrime(i) {
			fmt.Println(i)
		}
	}
}
