; Given a type (1) tree, determine the level of a node x given that the root is at level 0.

(defun get-left (lst)
    (get-subtree (cddr lst) 0 0)
)
(defun get-subtree (lst n e)
    (cond  
        ((null lst) nil)
        ((= e (- n 1)) nil) 
        (t  
            (cons (car lst) (cons (cadr lst) (get-subtree (cddr lst) (+ n 1) (+ e (cadr l)))))
        )
    )
)

(defun get-right (lst)
    (skip (cddr lst) 0 0)
)

(defun skip (lst n e)
    (cond  
        ((null lst) nil)
        ((= e (- n 1)) lst)
        (t  
            (skip (cddr lst) (+ n 1) (+ (cadr lst) e))
        )
    )
)

(defun count-depth (tree x)
    (cond  
        ((null tree) nil)
        ((equal (car tree) x) 0)
        (t  
            (cond  
                ((count-depth (get-right tree) x)
                    (+ 1 (count-depth (get-right tree) x))
                )
                ((count-depth (get-left tree) x)
                    (+ 1 (count-depth (get-left tree) x))
                )
                (t nil)
            )
        )
    )
)

