; Given a tree of type (1), Determine the height of the tree.

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

(defun height (tree) 
    ((null tree) 0)
    (t  
        (+ 1
            (max  
                (height (get-left tree))
                (height (get-right tree))
            )
        )
    )
)