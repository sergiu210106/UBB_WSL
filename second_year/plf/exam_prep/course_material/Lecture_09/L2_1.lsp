; Given a tree represented as recursive (value left_subtree right_subtree) tuples, Produce the list of nodes in left-root-right order (inorder).

(defun inorder(l)
    (cond
        ((null l) nil)
        (t (append (inorder (cadr l)) (list (car l)) (inorder (caddr l))))
        ; (t (append (inorder (cadr l)) (cons (car l) (inorder (caddr l)))))
    )
)

(write (inorder '(a (b () (f)) (d (e)))))