; Given a tree of type (2). Display the path from the root to a given node x

(defun get-left (lst) (cdr lst))
(defun get-right (lst) (cddr lst))

(defun path (tree x)
 (cond 
    ((null tree) nil)
    ((equal (car tree) x) (list x))
    (t  
        (cond  
            ((path (get-left tree) x)
                (cons (car tree) (path (get-left tree) x))
            )
            ((path (get-right tree) x)
                (cons (car tree) (path (get-right tree) x))
            )
            (t nil)
        )
    )
 )
)
