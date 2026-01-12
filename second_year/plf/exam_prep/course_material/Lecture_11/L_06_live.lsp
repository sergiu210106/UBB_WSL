(defun f (a L)
    (cond 
        ((atom L) (cond
            ((equal a L) 1)
            (t 0)
        ))
        (t (apply #'+ (mapcar #'(lambda  (L2) (f a L2)) L)))
    )
)

(write (f 'a '(1 (a (3 (4 a) a)) (7 (a 9)))))