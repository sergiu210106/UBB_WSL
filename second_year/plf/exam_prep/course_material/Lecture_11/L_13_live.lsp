(defun transpose (M)
    (cond
        ((null (car M)) nil)
        (t (cons
            (mapcar #'car M)
            (transpose (mapcar #'cdr M))
        ))
    )
)

(write (transpose '((1 2) (3 4) (5 6))))
(write-line "")

(defun dotprod (u v)
    (apply #'+ (mapcar #'* u v))
)

(write (dotprod '(1 2 3) '(4 5 6)))
(write-line "")

(defun mulTranspose (A B)
    (mapcar #'(lambda (M) (mapcar #'(lambda (N) (dotprod M N)) B)) A)
)

(write (mulTranspose '((1 2) (3 4) (5 6)) '((1 2) (3 4) (5 6))))
(write-line "")

(defun matmul (A B)
    (mulTranspose A (transpose B))
)

(write (matmul '((1 2) (3 4) (5 6)) '((1 3 5) (2 4 6))))
(write-line "")

(write (matmul '((1 3 5) (2 4 6)) '((1 2) (3 4) (5 6))))
(write-line "")