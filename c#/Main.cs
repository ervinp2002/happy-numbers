/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norm
Main Program in C#
*/

using System;
using System.Collections.Generic;
using System.Linq;

public class HappyNumbers {

    /* Struct helps to consolidate happy number attributes
       instead of using parallel arrays. */
    public struct HappyNumber {
    
        public long value {get;}
        public double norm {get; set;}
        
        public HappyNumber(long number) {
            value = number;
            norm = 0;
        }

        // Operator overloading will help with sorting. 
        public static bool operator < (HappyNumber arg1, HappyNumber arg2) {
            return arg1.norm < arg2.norm;
        }

        public static bool operator > (HappyNumber arg1, HappyNumber arg2) {
            return arg1.norm > arg2.norm;
        }

        public static bool operator <= (HappyNumber arg1, HappyNumber arg2) {
            return arg1.norm <= arg2.norm;
        }

        public static bool operator >= (HappyNumber arg1, HappyNumber arg2) {
            return arg1.norm >= arg2.norm;
        }
    }

    public static void Swap<T>(ref T arg1, ref T arg2) {
        // PRE: Arguments passed in were initialized. 
        // POST: Swaps the addresses of the argument. 

        T temp = arg1;
        arg1 = arg2;
        arg2 = temp;
    }

    // Overloaded swap for attributes that are already passed by reference. 
    public static void Swap<T>(T arg1, T arg2) {
        // PRE: Arguments passed in were initialized. 
        // POST: Swaps the addresses of the arguments. 

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

    public static double CalculateNorm(ref HappyNumber number) {
        // PRE: Struct has been instantiated with a value passed into it. 
        // POST: Returns the norm of the happy number. 

        long sum = 0;                       // Calculates sum of current number. 
        long total = 0;                     // Keeps track of overall sum. 
        long temp = number.value;           // Keeps track of current number in sequence. 

        while (temp != 1) {
            while (temp != 0) {
                long digit = temp % 10;
                sum += digit * digit;
                temp /= 10;
            }

            temp = sum;
            total += sum;
            sum = 0;
        }

        return Math.Sqrt(total + 1);
    }

    public static void Pincer(List<HappyNumber> list, int first, int last, out int split) {
        // PRE: To be used with a QuickSort. 
        // POST: Moves all values less than pivot to the left side and larger values to the right side.

        int pivot = first;
        int saveFirst = first;
        first++;

        while (first <= last) {
            while ((list[first] <= list[pivot]) && (first <= last)) first++;
            while ((list[last] >= list[pivot]) && (first <= last)) last--;

            if (first < last) {
                Swap(list[first], list[last]);
                first++;	
                last--;
            }
        }

        split = last;
        Swap(list[saveFirst], list[split]);
    }

    public static void QuickSort(List<HappyNumber> list, int first, int last) {
        // PRE: List is filled and is unsorted. 
        // POST: Recursively sorts the list by norm in ascending order. 

        if (first < last) {
            int splitPoint;
            Pincer(list, first, last, out splitPoint);
            QuickSort(list, first, splitPoint - 1);
            QuickSort(list, splitPoint + 1, last);

        }
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
            Swap(lower, upper);
        }

        for (long i = lower; i <= upper; i++) {
            if (IsHappy(i)) {
                HappyNumber number = new HappyNumber(i);
                happy.Add(number);
                number.norm = CalculateNorm(ref number);
            }
        }

        // Next step: Sort by norm
        QuickSort(happy, 0, happy.Count - 1);

        // Final step: output the happy numbers
    }
        
}

