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
            (when (= 1 n) (return (sqrt total)))   
            (setq addend (digitSum n))
            (setq total (+ total (square addend)))
            (setq n addend)
        )
    )
)

(defun findHappy ()
    "PRE: Hashtable for happy numbers, upper & lower bounds are passed in.
     POST: Adds happy numbers and their norms to the hash table."



)

; printResults function


; Main Program, referenced sample code from Lisp email. 
; POST: Outputs the 10 happy numbers with the highest norms. 

(defvar lower)
(defvar upper)

(princ "First Argument: ")
(terpri)
(setf lower (read))

(princ "Second Argument: ")
(terpri)
(setf upper (read))

(if (> lower upper)
    (rotatef lower upper)
)

(princ "Lower bound: ")
(princ lower)
(terpri)

(princ "Upper bound: ")
(princ upper)
(terpri)

(if (isHappy upper)
    (progn
        (princ "Upper bound is a happy number.")
        (terpri)
        (princ "Norm: ")
        (princ (findNorm upper))
        (terpri)
    )
)
