; Define a function that doubles all numeric atoms on any level of a list

(defun double (l)
    (cond
        ((null l) ())
        ((numberp (car l)) (cons (* 2 (car l)) (double (cdr l))))
        ((atom (car l)) (cons (car l) (double (cdr l))))
        (t (cons (double (car l)) (double (cdr l))))
    )
)

(write (double '(1 b 2 (c (3 h 4)) (d 6)))) ; -> (2 b 4 (c (6 h 8)) (d 12))
(write-line "")