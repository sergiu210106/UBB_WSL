;; Define a function that takes a multi level list and retuns the list of all
;; atoms at any level in reverse order

(defun my_reverse (l)
    (cond
        ((atom l) l)
        (t (append (my_reverse (cdr l)) (list (car l))))
    )
)

(defun reverse_l (L)
    (cond
        ((atom L) (list L))
        (t (mapcan #'reverse_l (my_reverse L)))
    )
)

(write-line "(G F E D C B A)")
(write (reverse_l '(A (B C (D (E))) (F G))))