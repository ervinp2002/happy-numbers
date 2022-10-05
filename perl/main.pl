#!/usr/bin/perl
=begin
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Number Norms
Main Program in Perl
=cut

use warnings FATAL => 'all';
use strict;

sub digitSum {
    # PRE: An integer is passed in as an argument. 
    # POST: Returns the squared digit sum of the argument.

    my $sum = 0;
    my $digit = 0;
    my $number = shift;

    for ($sum = 0; $number != 0; $number = int($number / 10)) {
        $digit = int($number % 10);
        $sum += $digit ** 2;
    }

    return $sum;
}

sub isHappy {
    # PRE: Argument passed in is within the bounds of the inpout range.
    # POST: Boolean value determines if the number is happy or not. 

    # This is the same approach as my C, Fortran, and Go implementations.
    my $number = shift;
    while ($number != 1 and $number != 4) {
        $number = digitSum($number);
    }

    return $number == 1 ? 1 : 0;
}

sub findNorm {
    # PRE: The passed argument was checked to be a happy number.
    # POST: Returns the norm of that happy number. 

    my $number = shift;
    my $total = 0;
    my $addend = 0;

    # Identical logic as C, Go, and Fortran implementations.
    if ($number == 1) {
        $total = 1;
    } else {
        $total = ($number ** 2) + 1;
        while ($number != 1) {
            $addend = digitSum($number);
            $total += ($addend ** 2);
            $number = $addend;
        }
    }

    return sqrt($total);
}

sub printResults {
    # PRE: Hash that is passed in is already filled.
    # POST: Outputs the happy numbers with the highest norms. 

    # Checks the length of the hash table.
    my $length = keys $_[0] >= 10 ? 10 : keys $_[0];
    my $index = 0;

    # Referred to official Perl documentation for sort in descending order.  
    my @list = sort {$b <=> $a} keys $_[0];
    if ($length == 0) {
        print("NOBODY'S HAPPY :(\n");
    } else {
        for ($index = 0; $index < $length; $index++) {
            # Call a hash table value using an element from the list as the key.
            print("$_[0]{$list[$index]}\n"); 
        }
    }  
}

# Main
# POST: Outputs the 10 happy numbers with the highest norms. 

my %happynums;
my $norm;

print "First Argument: ";
my $arg1 = <STDIN>;
chomp($arg1);

print "Second Argument: ";
my $arg2 = <STDIN>;
chomp($arg2);

if ($arg1 > $arg2) {
    ($arg1, $arg2) = ($arg2, $arg1);
}

for ($arg1 = $arg1; $arg1 <= $arg2; $arg1++) {
    if (isHappy($arg1)) {
        $norm = findNorm($arg1);
        $happynums{$norm} = $arg1;
    }
}

printResults(\%happynums);
