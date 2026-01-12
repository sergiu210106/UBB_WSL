;; Given a non-empty n-ary tree, represented as (root subtree1 ... subtreen),
;; determine the number of nodes in the tree

(defun nrNoduri(L)
    (cond
        ((null (cdr L)) 1)
        (t (+ 1 (apply
                    #'+
                    (mapcar #'nrNoduri (cdr L))
        )))
    )
)

(write-line "7")
(write (nrNoduri '(a (b (c) (d (e))) (f (g)))))