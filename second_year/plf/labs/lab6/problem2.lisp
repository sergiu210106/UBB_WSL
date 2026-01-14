; Display the list of nodes at level k from a tree of type (1).

(defun get_left (l) (get-subtree (cddr l) 0 0))

(defun get_right (l)
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

(defun level-k (lst k)
  (cond 
    ((null lst) 0)
    ((= k 0) (list (car tree)))
    (t  
      (append 
        (level-k (get-left lst) (- k 1))
        (level-k (get-right lst) (- k 1))
      )
    )
  )
)

