
(defun remove-adjacent (lst)
    (cond  
        ((null lst) nil) 
        ((equal (car lst) (cadr lst))
            (remove-adjacent (cdr lst))
        )
        (t  
            (cons (car lst) (remove-adjacent (cdr lst)))
        )
    )
)

(defun remove-all (lst e)
    (cond  
        ((null lst) nil)
        (equal (car lst) e) (remove-all (cdr lst) e)
        (t (cons (car lst) (remove-all (cdr lst) e)))
    )
)

(defun get-min (lst)
    (cond  
        ((null (cdr lst)) (car lst))
        (t  
            (min (car lst) (get-min (cdr)))
        )
    )
)

(defun min(a b)
    (cond  
        ((< a b) a)
        (t b)
    )
)

(defun sort-no-dups (lst)
    (cond  
        ((null lst) nil) 
        (t  
            (cons (get-min lst) sort-no-dups((remove-all lst (get-min lst))))
        )
    )
)