# Base 10 Happy Number Norms

## Project Summary
This project takes in a user-specifed range of positive integers and calculates the happy numbers that fall
within its range, along with the norm of each number. After checking the positive integers within the range,
the program then outputs at most the 10 happy numbers that have the highest norms within the range. Depending
on the language used, different data strucutres and strategies were implemented that were best suited depending 
on what features were supported in that particular language.

## Order of Completion
The order in which these languages had their implementation finished was done in the order below:

1. Java
2. Python
3. C#
4. C
5. Fortran
6. Go
7. Perl
8. Lisp

## Defining a Happy Number
For a base 10 number to be considered happy, that number must lead to 1 after following a sequence in which
each number is replaced by the sum of the square of each digit in the number.

Using 19 as an example:

~~~
19 => (1 * 1) + (9 * 9) = 82
82 => (8 * 8) + (2 * 2) = 68
68 => (6 * 6) + (8 * 8) = 100
100 => (1 * 1) + (0 * 0) + (0 * 0) = 1
~~~

Since 19 produces a sequence that leads to a 1, 19 is considered as base 10 happy.

## Calculating the Norm
The norm of a happy number is the square root of the sum of the square of each number in its sequence.

Using 19 as an example again:

~~~
Norm(19): sqrt((19 * 19) + (82 * 82) + (68 * 68) + (100 * 100) + (1 * 1)) = 147.343136929
~~~

## Compiling and Execution
All implementations can be compiled and executed as shown below:

### Java

**Implementation has a Client file and Happy Number file that must be in the same directory when compiling.**

    javac Main.java
    java Main

### Python

    python3 main.py

### C#

    mcs Main.cs
    mono Main.exe

### C 

    gcc -lm main.c
    ./a.out

### Fortran 

**Implementation will already have a module file or will produce a module file that must be in the same directory as the Fortran file.**

    gfortran main.f90
    ./a.out

### Go 

    go run main.go

### Perl 

**File must have execute permission turned on.**

    chmod u+x main.pl
    ./main.pl

### Lisp

**File must have execute permission turned on.**

    chmod u+x main.lisp
    ./main.lisp

