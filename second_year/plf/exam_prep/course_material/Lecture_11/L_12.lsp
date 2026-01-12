(defun p (L)
    (mapcan
        #'(lambda (e1) (mapcar
            #'(lambda (e2) (list e1 e2))
            L
        ))
        L
    )
)

(write-line "((1 1) (1 2) (1 3) (2 1) (2 2) (2 3) (3 1) (3 2) (3 3))")
(write (p '(1 2 3)))