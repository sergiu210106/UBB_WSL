; Define a function that keeps only numeric atoms from a list

(defun my_list (l)
    (cond
        ((null l) nil)
        ((numberp (car l)) (cons (car l) (my_list (cdr l))))
        (t (my_list (cdr l)))
    )
)

(write (my_list '(1 a 2 b 3 c)))