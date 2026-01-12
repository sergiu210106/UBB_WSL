;; Define a function that takes a list of equal length lists, representing a
;; matrix, and returns its transpose in a similar representation

(defun transpose (L)
    (cond
        ((null (car L)) nil)
        (t (cons
                (mapcar #'car L)
                (transpose (mapcar #'cdr L))
        ))
    )
)

(write-line "((1 4 7) (2 5 8))")
(write (transpose '((1 2) (4 5) (7 8))))