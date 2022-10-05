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

    public static double CalculateNorm(long number) {
        // PRE: Argument passed in is a happy number. 
        // POST: Returns the norm of the happy number. 

        // Reusing code from my Java implementation. 
        List<long> sequence = new List<long>();
        long m = 0;
        int digit = 0;

        sequence.Add(number);
        while (number != 1) {
            m = 0;
            while (number > 0) {
                digit = (int)(number % 10);
                m += digit * digit;
                number /= 10;
            }

            number = m;
            sequence.Add(number);
        }

        double total = 0;
        foreach (long element in sequence) {
            total += Math.Pow(element, 2);
        }
        sequence.Clear();

        return Math.Sqrt(total);
    }

    public static void Main() {
        // POST: Outputs the happy numbers with the highest norms.

        SortedList<double, long> happy = new SortedList<double, long>();
        string arg1, arg2;
        long upper, lower;

        try {
            Console.Write("First Argument: ");
            arg1 = Console.ReadLine();
            lower = long.Parse(arg1);

            Console.Write("Second Argument: ");
            arg2 = Console.ReadLine();
            upper = long.Parse(arg2);

            if (lower > upper) {
                long temp = lower;
                lower = upper;
                upper = temp;
            }

            for (long i = lower; i <= upper; i++) {
                if (IsHappy(i)) {
                    double norm = CalculateNorm(i);
                    happy.Add(norm, i);
                }
            }

            int size = happy.Count >= 10 ? 10 : happy.Count;
            if (size == 0) {
                Console.WriteLine("NOBODY'S HAPPY :(");
            } else {
                // Sorted List sorts in ascending order so list must be reversed. 
                List<double> keys = happy.Keys.ToList();
                keys.Reverse();

                // Acts as a pseudo-iterator to stop at a maximum of 10 outputted numbers. 
                int count = 0;
                foreach (double norm in keys) {
                    if (count < size) {
                        Console.WriteLine(happy[norm]);
                        count++;
                    }
                }
            }

        } catch (FormatException ex) {
            Console.WriteLine("Invalid input.");
        }
    }
}
