"""""
Ervin Pangilinan
CSC 330: Organization of Programming Languages
Project 1: Base 10 Happy Numbers Norms
Driver Program in Python3
"""

import math

def getArguments(argsList):
    # PRE: Upper and lower bound variables are passed as arguments. 
    # POST: Keyboard input is recorded as the upper and lower bounds. 

    # Exception handling added to take unwanted input into account. 
    while True:
        try:
            print("First Argument: ", end = "")
            argsList[0] = int(input())
            
            while argsList[0] < 0 or argsList[0] == None:
                print("First Argument: ", end = "")
                argsList[0] = int(input())

            break

        except ValueError:
            print("Invalid input.")
            
    while True:
        try:
            print("Second Argument: ", end = "")
            argsList[1] = int(input())

            while argsList[1] < 0 or argsList[1] == None or argsList[1] == argsList[0]:
                print("Second Argument: ", end = "")
                argsList[1] = int(input())

            if argsList[0] > argsList[1]: 
                temp = argsList[0]
                argsList[0] = argsList[1]
                argsList[1] = temp

            break

        except ValueError:
            print("Invalid input.")
    
# Function pulled from Rosetta Code. 
def happy(n):
    # PRE: Integer is passed in as a argument.  
    # POST: Returns a boolean that determines if the integer is happy or not. 

    # Set allows to check for cycle detection and remove duplicate values.	
    past = set()        	
    while n != 1:
        n = sum(int(i) ** 2 for i in str(n))
        if n in past:
            return False
        past.add(n)     # Unique values are added to the set. 
    return True

def getHappyNumbers(dictionary, lower, upper):
    # PRE: Empty dictionary, lower, and upper bounds are passed as arguments. 
    # POST: Puts norms-happy number pairs in dictionary. 

    for n in range(lower, upper):
        if (happy(n)): 
            value = n       # Save the value of the actual happy number. 
            sequence = set()    
            sequence.add(n)

            while n != 1:       # While-loop pulled from Rosetta Code. 
                n = sum(int(i) ** 2 for i in str(n))
                sequence.add(n)

            norm = math.sqrt(sum(int(i) ** 2 for i in sequence))
            dictionary.update({norm : value})

def happyPrint(normsList, dictionary):
    # PRE: Sorted list of norms and dictionary of norm-happy number pairs are filled. 
    # POST: Prints the happy numbers with the highest norms in descending order. 

    size = 10 if len(normsList) >= 10 else len(normsList)
    if size == 0: 
        print("NOBODY'S HAPPY :(")
    else: 
        for x in range(size): print(dictionary.get(normsList[x])) 

def main():
    # PRE: Keyboard input is taken to determine range to find happy numbers. 
    # POST: Outputs in descending order the happy numbers with the highest norms. 

    args = [0, 0]
    happy = {}

    getArguments(args)
    getHappyNumbers(happy, args[0], args[1])
    norms = list(map(float, happy.keys()))
    norms.sort(reverse = True)
    happyPrint(norms, happy)

main()
