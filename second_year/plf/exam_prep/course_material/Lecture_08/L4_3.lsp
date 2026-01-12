; Define a function that reverses a list

(defun my_reverse (l)
    (cond
        ((atom l) l)
        (t (append (my_reverse (cdr l)) (list (car l))))
    )
)

(defun rev_aux (l c)
    (cond
        ((null l) c)
        (t (rev_aux (cdr l) (cons (car l) c)))
    )
)
(defun my_reverse2 (l) (rev_aux l ()))

(write (my_reverse '(1 2 3)))
(write-line "")
(write (my_reverse2 '(1 2 3)))