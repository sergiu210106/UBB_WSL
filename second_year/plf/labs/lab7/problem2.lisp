; Define a function that given a multi level list returns the list of all atoms in the same order. E.g. (((A B) C) (D E)) →(A B C D E)

(defun flatten (lst)
    (cond  
        ((null lst) nil)
        ((atom lst) (list lst)) 
        (t (mapcan #'flatten lst))
    )
)