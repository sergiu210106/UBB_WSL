(defun perechi (e l)
    (cond
        ((null l) ())
        (t (cons (list e (car l)) (perechi e (cdr l))))
    )
)

(write (perechi 1 '(2 3 4))) ; ((1 2) (1 3) (1 4))
(write-line "")