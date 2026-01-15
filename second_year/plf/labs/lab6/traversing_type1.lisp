(defun get-left (lst)
    (get-subtree (cddr lst) 0 0)
)

(defun get-right (lst)
    (skip (cddr lst) 0 0)
)

(defun skip (lst n e)
    (cond  
        ((null lst) nil)
        ((= e (- n 1)) lst)
        (t  
            (skip (cddr lst) (+ 1 n) (+ (cadr lst) e))
        )    
    )
)

(defun get-subtree (lst n e)
    (cond  
        ((null lst) nil)
        ((= e (- n 1)) nil)
        (t  
            (cons (car lst) (cons (cadr lst) (get-subtree (cddr lst) (+ 1 n) (+ (cadr lst) e))))
        )    
    )
)