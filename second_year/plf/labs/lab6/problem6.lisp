; Return the list of nodes of a type (1) tree in in-order.

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

(defun in-order (lst)
    (append 
        (in-order (get-left lst))
        (list (car lst))
        (in-order (get-right lst))
    )
)