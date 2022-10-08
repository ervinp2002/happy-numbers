#! /usr/bin/sbcl --script
; Ervin Pangilinan
; CSC 330: Organization of Programming Languages
; Project 1: Base 10 Happy Number Norms
; Main Program in Lisp

(defun square (number)
    "PRE: Digit is passed in. 
     POST: Returns the square of the digit."

    (* number number)
)

(defun digitSum (number)
    "PRE: A postive integer is passed in as the argument. 
     POST: Returns the squared digit sum of the argument."

    (let ((n number) (digit 0) (sum 0))
        (loop 
            (setq digit (mod n 10))
            (setq sum (+ sum (square digit)))
            (setq n (values (floor n 10))) ; Division operator caused an infinite loop?
            (when (= n 0) (return sum))
        )
    )
)

(defun isHappy (number)
    "PRE: A positive integer is passed in as the argument.
     POST: Returns a boolean to determine if the argument is happy."

    ; The same approach as a bunch of my other implementations.
    (let ((n number))
        (loop
            (setq n (digitSum n))
            (when (or (= n 1) (= n 4)) (return (= 1 n)))
        )
    )
)

(defun findNorm (number)
    "PRE: Integer passed in was already checked to be a happy number. 
     POST: Calculates the norm of that happy number."

    (let ((n number) (total (square number)) (addend 1))
        (loop 
            ; Same approach as C implementation. 
            (when (= 1 n) (return (sqrt total)))   
            (setq addend (digitSum n))
            (setq total (+ total (square addend)))
            (setq n addend)
        )
    )
)

(defun findHappy (happyNums lower upper normList)
    "PRE: Hashtable and array for happy numbers, upper & lower bounds are passed in.
     POST: Adds happy numbers and their norms to the hash table."
    
    (let ((norm 1) (i lower) (index 0))
        (loop
            ; Variable "i" keeps track of what number within range is being iterated through.
            (when (> i upper) (return happyNums))
            (if (isHappy i)
                (progn
                    (setq norm (findNorm i))
                    (setf (gethash norm happyNums) i) ; Add to Hash Table. 

                    (if (> index 9)
                        (progn
                            (sort normList #'>) ; Sort in descending order.

                            ; Just like C, push out the minimum value after sorting.
                            (if (> norm (aref normList 9))
                                (progn
                                    (remhash (aref normList 9) happyNums)
                                    (setf (aref normList 9) norm)
                                )  
                            )
                        )
                    (setf (aref normList index) norm)) ; Else-clause when the array isn't completely filled up yet. 
                    (setq index (+ 1 index)) ; Increment each time there is a happy number. 
                )
            ) 
            (setq i (+ 1 i))
            (sort normList #'>) ; One last sort to have all norms in the right index in array. 
        )
    )
)

(defun printResults (normList table)
    "PRE: Hash table of pairs and array of norms are passed in.
     POST: Outputs the happy numbers with the highest norms."

    (let ((size (hash-table-count table)))
        ; Handles cases where there are more than 10 happy numbers within range by resetting to 10.
        (if (>= size 10)
            (setq size 10)
        )

        (dotimes (n size)
            ; Call a hash table value using an array element as the key. 
            (princ (gethash (aref normList n) table))
            (terpri)
        )

        ; Handles cases where there are no happy numbers in range.
        (if (= size 0)
            (princ "NOBODY'S HAPPY :(")
        )
    )
)

; Main Program, referenced sample code from Lisp email. 
; POST: Outputs the 10 happy numbers with the highest norms. 

; Contains upper and lower bounds of the input range. 
(defvar lower)
(defvar upper)

; Hash Table to contain happy number and norm pairs.
(defvar happyNums)
(setq happyNums (make-hash-table))

; List containing norms to be sorted. 
(defvar normList)
(setq normList (make-array '(10)))

(princ "First Argument: ")
(terpri)
(setq lower (read))

(princ "Second Argument: ")
(terpri)
(setq upper (read))

(if (> lower upper)
    ; Swap s-expresion
    (rotatef lower upper)
)

(terpri)
(setf happyNums (findHappy happyNums lower upper normList))
(printResults normList happyNums)
(terpri)
