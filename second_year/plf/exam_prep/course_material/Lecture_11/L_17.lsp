;; Given a set represented as a list determine the list of permutations of the
;; set

(defun permutations (L)
    (cond
        ((null (cdr L)) (list L))
        (t (mapcan
                #'(lambda (e)
                    (mapcar
                        #'(lambda (p) (cons e p))
                        (permutations (remove e L))
                    )
                )
                L
        ))
    )
)

(write-line "((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))")
(write (permutations '(1 2 3)))