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

    /* Struct helps to consolidate happy number attributes
       instead of using parallel arrays. */
    public struct HappyNumber {
    
        public long value {get;}
        public double norm {get;}
        
        public HappyNumber(long number) {
            value = number;
            norm = 0;
        }
    }

    public static void Swap<T>(ref T arg1, ref T arg2) {
        // PRE: Arguments passed in were initialized. 
        // POST: Swaps the addresses of the argument. 

        T temp = arg1;
        arg1 = arg2;
        arg2 = temp;
    }

    // Function pulled from Rosetta Code. 
    public static bool IsHappy(long n) {
        // PRE: Long integer has been passed in.
        // POST: Returns a boolean to determine if the long is happy.

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

    public static void Main() {
        // POST: Outputs the happy numbers with the highest norms.

        List<HappyNumber> happy = new List<HappyNumber>();

        Console.Write("First Argument: ");
        string arg1 = Console.ReadLine();
        long lower = long.Parse(arg1);

        Console.Write("Second Argument: ");
        string arg2 = Console.ReadLine();
        long upper = long.Parse(arg2);

        if (lower > upper) {
            Swap(ref lower, ref upper);
        }

        for (long i = lower; i <= upper; i++) {
            if (IsHappy(i)) {
                happy.Add(new HappyNumber(i));
            }
        }
    }
        
}

