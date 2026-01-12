;; Given a non-empty n-ary tree, represented as (root subtree1 ... subtreen)
;; determine the list of nodes at level n

(defun mylist(L n)
    (cond
        ((and (= n 0) (atom L)) (list L))
        ((= n 0) nil)
        ((atom L) nil)
        (t (mapcan
                #'(lambda (L) (mylist L (- n 1)))
                L
        ))
    )
)

(write-line "(B G H)")
(write (mylist '((a (b (c d))) e (f (g h (i)))) 3))
(write-line "")
(write-line "(C D I)")
(write (mylist '((a (b (c d))) e (f (g h (i)))) 4))
(write-line "")
(write-line "NIL")
(write (mylist '((a (b (c d))) e (f (g h (i)))) 5))