; Define a function that keeps only numeric atoms from a list

(defun keep_numbers (l)
    (cond
        ((numberp l) (list l))
        ((atom l) ())
        (t (append (keep_numbers (car l)) (keep_numbers (cdr l))))
    )
)

(write (keep_numbers '(1 a 2 b 3 c))) ; -> (1 2 3)