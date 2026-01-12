(defun f (L)
    (cond
        ((null (cdr L)) (list L))
        (t (mapcan #'(lambda (e)
            (mapcar #'(lambda (p) (cons e p)) (f (remove e L)))
        )
        L
        ))
    )
)

(write (f '(1 2 3)))