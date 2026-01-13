; Define a function that returns the sum of all numeric atoms in a multi level list

(defun sum-atoms (lst)
    (cond  
        ((numberp lst) lst)
        ((atom lst) 0)
        (t 
            (apply #'+ (mapcar #'sum-atoms lst))
        )
    )
)

(print(sum-atoms '(1 (a 32) ((b) 1))))