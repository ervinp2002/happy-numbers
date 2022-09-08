/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norm
Main Program in C#
*/

using System.Math;
using System.Collections;
using System.Linq;

class Main {

    public struct HappyNumber {
    
        public long value;
        public double norm;
        
        public HappyNumber(long number) {
            value = number;
            norm = 0;
        }
    }

    public static void swap(ref object arg1, ref object arg2) {
        // PRE:
        // POST:

        object temp = arg1;
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
                int digit = n % 10;
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
        String arg1 = Console.ReadLine();
        long lower = long.parse(arg1);

        Console.Write("Second Argument: ");
        String arg2 = Console.ReadLine();
        long upper = long.parse(arg2);

        if (lower > upper) {
            swap(lower, upper);
        }

        


    }
        
}

