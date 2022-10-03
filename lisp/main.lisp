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
            (setq n (values (floor n 10)))
            (when (= n 0) (return sum))
        )
    )
)

(defun isHappy (number)
    "PRE: A positive integer is passed in as the argument.
     POST: Returns a boolean to determine if the argument is happy."

    
)

; findNorm function


; findHappy function


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

(princ "Lower is ")
(princ lower)
(terpri)
(princ "Upper is ")
(princ upper)
(terpri)
(princ (digitSum upper))
(terpri)
