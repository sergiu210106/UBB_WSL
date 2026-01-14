; Convert a tree of type (2) into a tree of type (1).

(defun convert (tree)
    ((null tree) nil) 
    (t  
        (append  
            (list (car tree) (count-children (cdr tree)))
            (convert (cadr tree))
            (convert (caddr tree))
        )
    )
)

(defun count-children (subtrees)
    (cond  
        ((null subtrees) 0)
        ((null (car subtrees)) (count-children (cdr subtrees)))
        (t (+ 1 count-children (cdr subtrees)))
    )
)

