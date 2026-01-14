; Convert a tree of type (1) into a tree of type (2). 

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


(defun convert (lst)
    (cond  
        ((null lst) nil)
        (t (cons (car lst) (convert lst (cadr lst))))
    )
)

(defun convert_subtrees (lst count)
    (cond  
        ((= count 0) nil)
        ((= count 1) (list (convert (get-left lst))))
        (t (list (convert (get-left lst)) (convert (get-right lst))))
    )
)