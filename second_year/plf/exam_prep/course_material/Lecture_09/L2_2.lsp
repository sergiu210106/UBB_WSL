; Given a tree represented in (value num_children left_subtree right_subtree), produce the list of nodes in left-root-right order (inorder).

(defun get_tree (tree ne nn)
    (cond
        ((null tree) ())
        ((= nn (+ 1 ne)) ())
        (t
            (cons
                (car tree)
                (cons
                    (cadr tree)
                    (get_tree (cddr tree) (+ (cadr tree) ne) (+ 1 nn))
                )
            )
        )
    )
)

(defun get_left_tree  (tree)
    (get_tree (cddr tree) 0 0)
)

(defun _get_right_tree (tree ne nn)
    (cond
        ((null tree) ())
        ((= nn (+ 1 ne)) tree)
        (t (_get_right_tree (cddr tree) (+ (cadr tree) ne) (+ 1 nn)))

    )
)

(defun get_right_tree (tree)
    (_get_right_tree (cddr tree) 0 0)
)

(defun inorder (tree)
    (cond
        ((null tree) ())
        (t (append (inorder (get_left_tree tree)) (cons (car tree) (inorder (get_right_tree tree)))))
    )
)

(write (inorder '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0)))
(write-line "")
(write (get_left_tree '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0)))
(write-line "")
(write (get_right_tree '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0)))