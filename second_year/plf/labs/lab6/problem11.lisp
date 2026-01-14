; Given a type (2) tree, determine the level with the most nodes and the associated list of nodes,
; considering the level of the root to be 0.

(defun sum_lists (l1 l2)
  (cond
    ((null l1) l2)
    ((null l2) l1)
    (t (cons (+ (car l1) (car l2)) (sum_lists (cdr l1) (cdr l2))))
  )
)

(defun sum_all (lists)
  (cond 
    ((null lists) nil)
    (t (sum_lists (car lists) (sum_all (cdr lists))))
  )
)

(defun count (tree)
  (cons 1 (sum_all (mapcar #'count (cdr tree))))
)

(defun width (tree)
  (apply #'max (count tree))
)