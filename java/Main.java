/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Client Program in Java
*/

import java.util.*;
import java.io.*;
import java.lang.Math;

public class Main {
    
    // Pulled from Rosetta Code. 
    public static boolean happy(long number) {
        // PRE: Long integer is passed as an argument. 
        // POST: Determines if the argument is a happy number. 

        long m = 0;
        int digit = 0;
        HashSet<Long> cycle = new HashSet<Long>();

        while (number != 1 && cycle.add(number)) {
            m = 0;
            while (number > 0) {
                digit = (int)(number % 10);
                m += digit * digit;
                number /= 10;
            }
            
            number = m;
        }

        return number == 1;
    }

    public static void getHappyNumbers(long lower, long upper, TreeMap<Double, String> tree) {
        // PRE: Lower, upper bounds, and TreeMap are passed as arguments. 
        // POST: Finds happy numbers that fall within bounds and puts values and norms into TreeMap. 

        for (long i = (long)lower; i < (long)upper; i++) {
            if (happy(i)) {
                HappyNumber happy = new HappyNumber(i);
                tree.put(new Double(happy.getNorm()), happy.toString()); 
            }
        }
    }

    public static void printNorms(TreeMap<Double, String> tree) {
        // PRE: TreeMap containing happy numbers and norms is passed as argument. 
        // POST: Outputs in descending order the 10 highest norms or all norms if TreeMap size is less than 10. 

        if (tree.size() == 0) {
            System.out.println("NOBODY'S HAPPY :(");
        } else {
            Iterator treeItr = tree.values().iterator();
            int i = 0;
            int size = tree.size() <= 10 ? tree.size() : 10;
            while (treeItr.hasNext() && i < size) {
                System.out.println(treeItr.next());
                i++;
            }
        }
    }

    public static void main(String args[]) {
        // PRE: Keyboard input will be taken to determine upper and lower bounds of range.
        // POST: Top 10 happy numbers with the greatest norms will be outputted in descending order. 

        // TreeMap allows for traversal and insertion in O(log n). 
        TreeMap<Double, String> numbers = new TreeMap(Collections.reverseOrder());
        Scanner stdin = new Scanner(System.in);
        int lower = 0;
        int upper = 0; 

        try {
            System.out.print("First Argument: ");
            lower = stdin.nextInt();

            // Prevent 0 and negative integers from being recorded.
            while (lower <= 0) { 
                System.out.print("First Argument: ");
                lower = stdin.nextInt();
            }

            System.out.print("Second Argument: ");
            upper = stdin.nextInt();

            // Prevents 0, negative integers, and duplicate values from being recorded.
            while (upper <= 0 || upper == lower) { 
                System.out.print("Second Argument: ");
                upper = stdin.nextInt();  
            }

        } catch (InputMismatchException e) {    // Prevents other token types from being inputted.
            System.out.println("Invalid input.");
        }

        // In-line swap is used since Java variables are not pass-by-reference.
        int temp = lower;
        if (lower > upper) {
            lower = upper;
            upper = temp;
        }
    
        getHappyNumbers(lower, upper, numbers);
        printNorms(numbers);
        stdin.close();
    } 
}
