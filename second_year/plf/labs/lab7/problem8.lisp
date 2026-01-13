; Define a function that returns the maximum value of a multi level list.

(defun max-list (lst)
    (cond 
        ((numberp lst) lst)
        ((atom lst) 0)
        (t  
            (apply #'max (mapcar #'max-list lst))
        )
    )
)

(print (max-list '(1 (2 a) ((3 b) 6))))