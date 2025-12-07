; 12. Return the list of nodes of a type (2) tree in pre-order.

(defun pre-order (tree)
  (cond
    ((null tree) nil)
    
    (t (cons (car tree) (mapcan #'pre-order (cdr tree))))
  )
)