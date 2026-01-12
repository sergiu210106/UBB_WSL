; Sort a list using tree-sort

(defun insert(e arb)
    (cond
        ((null arb) (list e))
        ((<= e (car arb)) (list (car arb) (insert e (cadr arb)) (caddr arb)))
        (t (list (car arb) (cadr arb) (insert e (caddr arb))))
    )
)

(defun construct(l)
    (cond
        ((null l) nil)
        (t (insert (car l) (construct (cdr l))))
    )
)

(defun inorder (arb)
    (cond
        ((null arb) nil)
        (t (append (inorder (cadr arb)) (list (car arb)) (inorder (caddr arb))))
    )
)

(defun tree_sort(l)
    (inorder (construct l))
)

(write (tree_sort '(5 1 4 6 3 2 )))