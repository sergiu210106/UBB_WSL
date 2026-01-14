; Return the list of nodes of a type (2) tree in in-order.

(defun get-left (lst)
    (cadr lst)
)
(defun get-right (lst)
    (cddr lst)
)

(defun in-order (lst)
    (append  
        (cadr lst)
        (list (car lst))
        (caddr lst)
    )
)