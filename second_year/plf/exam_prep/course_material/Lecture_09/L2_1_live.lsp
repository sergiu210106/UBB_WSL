(defun inorder (tree)
    (cond
        ((null tree) ())
        (t (append (inorder (cadr tree)) (cons (car tree) (inorder (caddr tree)))))
    )
)

(defun preorder (tree)
    (cond
        ((null tree) ())
        (t (cons (car tree) (append (preorder (cadr tree)) (preorder (caddr tree)))))
    )
)

(write (inorder '(1 (2 (3) (4)) (3))))
(write-line "")

(write (preorder '(1 (2 (3) (4)) (3))))