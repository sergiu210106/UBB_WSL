
(defun push_left (e l)
    (cond
        ((null l) ())
        (t (cons (cons e (car l)) (push_left e (cdr l))))
    )
)

(defun subsets (l)
    (cond
        ((null l) (list ()))
        (t (append (subsets (cdr l)) (push_left (car l) (subsets (cdr l)))))
    )
)

(write (push_left 1 '(() (2) (3 4))))
(write-line "")
(write (subsets '(1 2 3))) ; (() (1) (2) (3) (1 2) (1 3) (2 3) (1 2 3))