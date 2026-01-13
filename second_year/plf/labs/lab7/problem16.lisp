; Define a function that reverses a list along with all its sublists

(defun deep-reverse (lst)
    (cond  
        ((atom lst) lst)
        (t
            (reverse (mapcar #'deep-reverse lst))
        )
    )
)

(print (deep-reverse '(a (b (c)) (d) (e (f) g))))