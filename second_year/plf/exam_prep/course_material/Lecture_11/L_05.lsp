;; Define a function that takes a multi-level list and returns the list of all
;; atoms at any level

(DEFUN atoms (L)
    (COND
        ((ATOM L) (LIST L))
        (T (MAPCAN #'atoms L))
    )
)

(write-line "(1 2 3 4 5 6 7 8 9)")
(write (atoms '(1 (2 (3 (4 5) 6)) (7 (8 9)))))
(write-line "")

(DEFUN atoms2 (L)
    (COND
        ((ATOM L) (LIST L))
        (T (APPLY #'APPEND (MAPCAR #'atoms2 L)))
    )
)

(write-line "(1 2 3 4 5 6 7 8 9)")
(write (atoms2 '(1 (2 (3 (4 5) 6)) (7 (8 9)))))