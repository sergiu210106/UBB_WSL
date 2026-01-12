;; Given a non-empty n-ary tree, represented as (root subtree1 ... subtreen)
;;  determine the height of the tree

(defun height(L)
    (cond
        ((null (cdr L)) 0)
        (t (+ 1 (apply
                    #'max
                    (mapcar #'height (cdr L))
        )))
    )
)

(write-line "3")
(write (height '(a (b (c) (d (e))) (f (g)))))