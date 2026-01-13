;Define a function that substitutes an element E with the elements of a list L1 in a multi level list L.

(defun subs-list (lst e l1)
    (cond  
        ((equal e lst) l1)
        ((atom lst) (list lst))
        (t 
            (list (mapcan (lambda (c) (subs-list c e l1)) lst))
        )
    )
)
(print (subs-list '(1 (2 a) 3) 'a '(x y z)))