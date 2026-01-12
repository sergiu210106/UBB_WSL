; Define a function that doubles all numeric atoms on any level of a list

(defun double(l)
    (cond
        ((null l) nil)
        ((numberp (car l)) (cons (* 2 (car l)) (double (cdr l))))
        ((atom (car l)) (cons (car l) (double (cdr l))))
        (t (cons (double (car l)) (double (cdr l))))
    )
)

(defun double2(l)
    (cond
        ((numberp l) (* 2 l))
        ((atom l) l)
        (t (cons (double2 (car l)) (double2 (cdr l))))
    )
)

(write (double '(1 b 2 (c (3 h 4)) (d 6))))
(write-line "")
(write (double2 '(1 b 2 (c (3 h 4)) (d 6))))