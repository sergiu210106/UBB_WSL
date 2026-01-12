(defun f (level tree)
    (cond
        ((null tree) nil)
        ((equal 0 level) (list (car tree)))
        (t (apply #'append (mapcar #'(lambda  (L2) (f (- level 1) L2)) (cdr tree))))
    )
)

(write (f '2 '(a (b nil (d)) (c (e) (f)))))