(defun get_subtrees_aux (l v)
    (cond
        ((null l) (cons nil nil))
        ((equal v 0) (cons () (list l)))
        (t (helper (car l) (cadr l) (get_subtrees_aux (cddr l) (+ v (- (cadr l) 1)))))
    )
)

(defun helper (e1 e2 pair)
    (cons (cons e1 (cons e2 (car pair))) (cdr pair))
)

(defun get_subtrees (l)
    (get_subtrees_aux (cddr l) 1)
)

(defun inorder_aux (v pair)
    (append (inorder (car pair)) (cons v (inorder (cdr pair))))
)

(defun inorder (tree)
    (cond
        ((null tree) ())
        (t (inorder_aux (car tree) (get_subtrees tree)))
    )
)

(write (get_subtrees '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0))) ; ((b 2 c 1 i 0 f 1 g 0) . (d 2 e 0 h 0))
(write-line "")
(write (get_subtrees '(a 1 b 0))) ; ((b 2 c 1 i 0 f 1 g 0) . (d 2 e 0 h 0))
(write-line "")
; (write (inorder '(a 0))) ; i c b g f a e d h
(write (inorder '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0))) ; i c b g f a e d h