; Compute the sum of all numeric atoms at all levels of a list

(defun sum (l)
    (cond
        ((null l) 0)
        ((numberp (car l)) (+ (car l) (sum (cdr l))))
        ((atom (car l)) (sum (cdr l)))
        (t (+ (sum (car l)) (sum (cdr l))))
    )
)
(write (sum '(1 (2 a (3 4) b 5) c 1)))
(write-line "")

(defun sum2 (l)
    (cond
        ((not l) 0)
        ((numberp l) l)
        ((atom l) 0)
        (t (+ (sum2 (car l)) (sum2 (cdr l))))
    )
)
(write (sum2 '(1 (2 a (3 4) b 5) c 1)))