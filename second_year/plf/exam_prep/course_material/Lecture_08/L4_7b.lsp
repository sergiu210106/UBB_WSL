; Define a function that keeps only numeric atoms from a list

(defun list_aux (l col)
    (cond
        ((null l) col)
        ((numberp (car l)) (list_aux (cdr l) (append col (list (car l)))))
        (t (list_aux (cdr l) col))
    )
)

(defun my_list (l)
    (list_aux l nil)
)

(write (my_list '(1 a 2 b 3 c)))