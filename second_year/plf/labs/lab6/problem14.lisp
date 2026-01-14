; Return the list of nodes of a type (2) tree in post-order.
(defun get-left (lst) (cadr lst))
(defun get-right (lst) (cadr lst))

(defun post-order (lst)
    (cond  
        ((null lst) nil)
        (t  
            (append 
                (post-order (get-left lst))
                (list (car lst))
                (post-order (get-right lst))
            )
        )
    )
)