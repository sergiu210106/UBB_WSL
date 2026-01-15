; Given a tree of type (1). Display the path from the root to a given node x.

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

(defun path (tree x)
  (cond  
    ((null tree) nil)
    ((= (car tree) x) (list x))
    (t  
      (cond  
        ((path (get_left tree) x) 
          (cons (car tree) (path (get_left tree) x))
        )
        ((path (get_right tree) x)
          (cons (car tree) (path (get_right tree) x))
        )
        (t nil)
      )
    )
  )
)




