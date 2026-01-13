; Define a function that deletesall appearances of a atom in a multi leve list.

(defun delete-all (lst e)
    (cond  
        ((equal e lst) nil)
        ((atom lst) (list lst))
        (t  
            (mapcan (lambda (c) (delete-all c e)) lst)
        )
    )
)

(print (delete-all '(1 (2 3 a (1 b )) 5) '1))