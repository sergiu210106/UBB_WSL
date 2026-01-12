(defun insert_at (e n l)
    (cond
        ((= n 0) (cons e l))
        ((null l) (list e))
        (t (cons (car l) (insert_at e (- n 1) (cdr l))))
    )
)

(defun insert_all (e n l)
    (cond
        ((= n 0) (list (insert_at e 0 l)))
        (t (cons (insert_at e n l) (insert_all e (- n 1) l)))
    )
)

(defun insert_aux (e l)
    (cond
        ((null l) ())
        (t (append (insert_all e (length (car l)) (car l)) (insert_aux e (cdr l))))
    )
)

(defun all_perm (l)
    (cond
        ((null l) (list nil))
        (t (insert_aux (car l) (all_perm (cdr l))))
    )
)

(write (insert_at 1 14 '(3 4 5)))
(write-line "")
(write (insert_aux 1 '((2 3) (4 5))))
(write-line "")
(write (all_perm '(1 2 3)))