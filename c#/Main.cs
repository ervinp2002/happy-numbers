/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norm
Main Program in C#
*/

using System;
using System.Collections.Generic;
using System.Linq;

class HappyNumbers {

    public struct HappyNumber {
    
        public long value;
        public double norm;
        
        public HappyNumber(long number) {
            value = number;
            norm = 0;
        }
    }

    public static void swap<T>(ref T arg1, ref T arg2) {
        // PRE: Arguments passed in have been initialized. 
        // POST: Swaps the addresses of the argument. 

        T temp = arg1;
        arg1 = arg2;
        arg2 = temp;
    }

    // Function pulled from Rosetta Code. 
    public static bool ishappy(long n) {
        List<long> cache = new List<long>();
        long sum = 0;

        while (n != 1) {
            if (cache.Contains(n)) {
                return false;
            }

            cache.Add(n);
            while (n != 0) {
                long digit = n % 10;
                sum += digit * digit;
                n /= 10;
            }

            n = sum;
            sum = 0;
        }

       return true;       
    }

    static void Main() {

        Console.Write("First Argument: ");
        string arg1 = Console.ReadLine();
        long lower = long.Parse(arg1);

        Console.Write("Second Argument: ");
        string arg2 = Console.ReadLine();
        long upper = long.Parse(arg2);

        if (lower > upper) {
            swap(ref lower, ref upper);
        }

        

    }
        
}

