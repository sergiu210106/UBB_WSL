; Define a function that returns the product of all numeric atoms on a multi level list.
(defun prod-list (lst)
    (cond   
        ((numberp lst) lst)
        ((atom lst) 1)
        (t 
            (apply #'* (mapcar #'prod-list lst))
        )
    )
)

(print (prod-list '(1 (a 3) ((b 5) 1))))