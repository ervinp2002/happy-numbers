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

(defun findHappy (happyNums lower upper normList)
    "PRE: Hashtable for happy numbers, upper & lower bounds are passed in.
     POST: Adds happy numbers and their norms to the hash table."
    
    (let ((norm 1) (i lower))
        (loop
            (when (> i upper) (return happyNums))
            (if (isHappy i)
                (progn
                    (setq norm (findNorm i))
                    (setf (gethash norm happyNums) i)
                    (setq normList (push 'i normList))
                )
            ) 
            (setq i (+ 1 i))  
        )
    )
)


(defun printResults (normList table)
    (let ((size (length normList)) (counter 0))
        (if (>= size 10)
            (setq size 10)
        )

        (dolist (index normList)
            (when (= counter size) (return))
            (princ (gethash 'index table))
            (terpri)
            (setq counter (+ counter 1))
        )
    )
)

; Main Program, referenced sample code from Lisp email. 
; POST: Outputs the 10 happy numbers with the highest norms. 

(defvar lower)
(defvar upper)

(defvar happyNums)
(setq happyNums (make-hash-table))

(defvar normList)
(setq normList nil)

(princ "First Argument: ")
(terpri)
(setq lower (read))

(princ "Second Argument: ")
(terpri)
(setq upper (read))

(if (> lower upper)
    (rotatef lower upper)
)

(terpri)
(setf happyNums (findHappy happyNums lower upper normList))
(sort normList #'>)

(printResults normList happyNums)
(terpri)
