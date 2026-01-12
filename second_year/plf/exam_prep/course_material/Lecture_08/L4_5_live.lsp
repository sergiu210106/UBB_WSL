(defun pairs_aux (e l)
    (cond
        ((null l) ())
        ((< e (car l)) (cons (list e (car l)) (pairs_aux e (cdr l))))
        (t (pairs_aux e (cdr l)))
    )
)

(defun pairs (l)
    (cond
        ((null l) ())
        (t (append (pairs_aux (car l) (cdr l)) (pairs (cdr l))))
    )
)

(write (pairs_aux 3 '(1 5 0 4))) ;--> ((3 5) (3 4))
(write-line "")
(write (pairs '(3 1 5 0 4))) ;--> ((3 5) (3 4) (1 5) (1 4) (0 4))
(write-line "")