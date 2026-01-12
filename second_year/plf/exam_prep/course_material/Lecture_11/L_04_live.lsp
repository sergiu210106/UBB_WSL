(defun f (L)
    (cond
        ((atom L) 0)
        (t (+ (mod (+ (length L) 1) 2) (apply #'+ (mapcar #'f L))))
    )
)

(write (f '(1 (2 (3 (4 5) 6)) (7 (8 9)))))