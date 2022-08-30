# Ervin Pangilinan
# CSC 330: Organization of Programming Languages
# Project 1: Base 10 Happy Numbers Norms
# Driver Program in Python3

import itertools
import math

def getArguments(argsList):
    # PRE: Upper and lower bound variables are passed as arguments. 
    # POST: Keyboard input is recorded as the upper and lower bounds. 

    print("First Argument: ", end = "")
    argsList[0] = int(input())
    
    while argsList[0] < 0 or argsList[0] == None:
        print("First Argument: ", end = "")
        argsList[0] = int(input())
    
    print("Second Argument: ", end = "")
    argsList[1] = int(input())

    while argsList[1] < 0 or argsList[1] == None or argsList[1] == argsList[0]:
        print("Second Argument: ", end = "")
        argsList[1] = int(input())

    if argsList[0] > argsList[1]: 
        temp = argsList[0]
        argsList[0] = argsList[1]
        argsList[1] = temp

# Function pulled from Rosetta Code. 
def happy(n):
    past = set()			
    while n != 1:
        n = sum(int(i) ** 2 for i in str(n))
        if n in past:
            return False
        past.add(n)
    return True

args = [0, 0]
getArguments(args)
print(str(args[0]) + " " + str(args[1]))


