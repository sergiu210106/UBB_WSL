; Define a function that reverses a list along with all its sublists

(defun deep-reverse (lst)
    (cond  
        ((atom lst) lst)
        (t
            (my-reverse (mapcar #'deep-reverse lst))
        )
    )
)

(defun my-reverse (lst) 
    (cond 
        ((null lst) nil)
        (t 
            (append 
                (my-reverse (cdr lst))
                (list (car lst))
            )
        )
    )
)

(print (deep-reverse '(a (b (c)) (d) (e (f) g))))