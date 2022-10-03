#! /usr/bin/sbcl --script
; Ervin Pangilinan
; CSC 330: Organization of Programming Languages
; Project 1: Base 10 Happy Number Norms
; Main Program in Lisp

(defun digitSum (number)
   "PRE: An integer is passed in as the argument. 
    POST: Returns the squared digit sum of the argument."

    (do ((n number (/ n 10))
         (digit 0 (mod n 10))
         (sum 0 (+ sum (* digit digit)))
        )
        ((= n 0))
    ) 
)

; isHappy function


; findNorm function


; findHappy function


; printResults function


; Main Program, referenced sample code from Lisp email. 
(progn
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

    (princ (digitSum 10))
)

