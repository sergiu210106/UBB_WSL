(defun flatten (lst)
    (cond  
        ((null lst) nil)
        ((atom (car lst)) 
            (cons (car lst) (flatten (cdr lst)))
        )
        (t  
            (append (flatten (car lst)) (flatten (cdr lst)))
        )
    )
)

(defun member (lst e)
    (cond  
        ((null lst) nil)
        ((equal (car lst) e) t) 
        (t member (cdr lst) e)
    )
) 


(defun intersection (l1 l2)
    (cond 
        ((null l1) nil) 
        ((member l2 (car l1)) (cons (car l1) (intersection (cdr l1) l2)))
        (t  
            (intersection (cdr l1) l2)
        )
    )
)