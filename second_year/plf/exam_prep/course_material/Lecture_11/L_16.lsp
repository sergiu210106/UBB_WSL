;;  Given a set represented as a list determine the list of subsets.

(defun subsets (L)
    (cond
        ((null L) (list nil))
        (t (
            (lambda (s)
                (append s (mapcar
                    #'(lambda (sb)
                        (cons (car L) sb)
                    )
                    s
                ))
            )
            (subsets (cdr L))
        ))
    )
)

(write-line "(NIL (1) (2) (1 2))")
(write (subsets '(1 2)))
(write-line "")
(write-line "((1 2 3) (1 3 2))")
(setq e 1)
(write (mapcar #'(lambda(L) (cons e L)) '((2 3) (3 2))))