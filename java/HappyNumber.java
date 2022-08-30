/*
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Happy Number Class Implementation
*/

import java.lang.Math;
import java.util.*;

/*
Implementation assumes that the value passed into the constructor
was already checked if it was a happy number.
*/

public class HappyNumber {

    // Private Instance Variables
    private long value;
    private double norm;
    private ArrayList<Long> sequence;

    // Constructor
    public HappyNumber(long number) {
        value = number;
        sequence = createSequence(number);
        norm = calculateNorm();
    }

    // Setter Methods
    private ArrayList<Long> createSequence(long number) {
        // PRE: Called when HappyNumber object is declared. 
        // POST: Returns an ArrayList containing the sequence of a happy number. 

        ArrayList<Long> temp = new ArrayList<Long>();
        long m = 0;
        int digit = 0;

        temp.add(number);
        while (number != 1) {       // Double while-loop pulled from Rosetta Code. 
            m = 0;
            while (number > 0) {
                digit = (int)(number % 10);
                m += digit * digit;
                number /= 10;
            }

            number = m;
            temp.add(number);
        }

        return temp;
    }

    private double calculateNorm() {
        // PRE: Called when HappyNumber object is declared. 
        // POST: Returns the norm of a happy number. 

        long total = 0;
        for (Long number : sequence) {
            total += Math.pow(number, 2);
        }

        return Math.sqrt(total);
    }

    // Getter Methods
    public String toString() {
        return String.valueOf(this.value);
    }

    public double getNorm() {
        return this.norm;
    }
}
