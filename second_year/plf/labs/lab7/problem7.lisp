; Define a function that returns the sum of all even numbers minus the sum of all odd numbers in a multi level list.

(defun even-odd (lst)
    (cond  
        ((numberp lst) 
            (cond  
                ((evenp lst) lst)
                (t (* -1 lst))
            )   
        )
        ((atom lst) 0)
        (t  
            (apply #'+ (mapcar #'even-odd lst))
        )
    )   
)

(print (even-odd '(1 (2 a) ((3 b) 6))))