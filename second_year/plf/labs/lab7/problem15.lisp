; Define a function that returns the number of atoms in a multi level list

(defun count-atoms (lst)
    (cond   
        ((atom lst) 1)
        (t 
            (apply #'+ (mapcar #'count-atoms lst))
        )
    )
)

(print (count-atoms '(a (b (c)) (d) (e (f) g))))