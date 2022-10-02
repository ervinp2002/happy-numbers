#! /usr/bin/sbcl --script
; Ervin Pangilinan
; CSC 330: Organization of Programming Languages
; Project 1: Base 10 Happy Number Norms
; Main Program in Lisp

(defun swap (arg1 arg2)
    ; PRE: Two initialized variables are passed in. 
    ; POST: Swaps the value of those variables. 

    (rotatef arg1 arg2)
)

; digitSum function


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
        (swap lower upper)
    )


)
