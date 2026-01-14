;  Return the list of nodes of a type (1) tree in post-order.

(defun get-left (lst)
    (get-subtree (cddr lst) 0 0)
)

(defun get-right (lst)
    (skip (cddr l) 0 0)
)

(defun skip (l n e)
  (cond
    ((null l) nil)
    ((= e (- n 1)) l)
    (t (skip (cddr l) (+ 1 n) (+ (cadr l) e)))
  )
)

(defun get-subtree (lst n e)
  (cond  
    ((null lst) nil)
    ((= e (- n 1)) nil)
    (t 
      (cons  
        (car l) (cons (cadr l) (get-subtree (cddr l) (+ 1 n) (+ (cadr l) e)))
      )
    )
  )
)

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