; Define a function that determines the depth of a multi level list.

(defun depth (x)
    (cond 
        ((atom x) 0)
        ((null x) 1)
        (t (+ 1 (apply #'max (mapcar #'depth x))))
    )
)