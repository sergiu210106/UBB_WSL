; given a set, produce the list of all possible subsets
(defun pushLeft(e l)
    (cond
        ((null l) nil)
        (t (cons (cons e (car l)) (pushLeft e (cdr l))))
    )
)

(defun subsets(l)
    (cond
        ((null l) (list nil))
        (t (append (subsets (cdr l)) (pushLeft (car l) (subsets (cdr l)))))
    )
)

(write (pushLeft '3 '(() (2) (1) (1 2))))
(write-line "")
(write (subsets '(1 2)))