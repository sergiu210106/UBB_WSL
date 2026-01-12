; Define a function that generates the list of pairs formed from an element and the items in a list

(defun pairs (e l)
    (cond
        ((null l) NIL)
        ((atom l) (cons e (list l)))
        (t (cons (pairs e (car l)) (pairs e (cdr l))))
    )
)

(write (pairs 'A '(B C D)))
(write-line "")