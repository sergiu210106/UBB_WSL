(defun f (a L)
    (cond
        ((atom L) (cond
            ((equal a L) ())
            (t (list L))
        ))
        (t (list (apply #'append (mapcar #'(lambda  (L2) (f a L2)) L))))
    )
)

(write (f 'a '(1 (a (3 (4 a) a)) (7 (a 9)))))