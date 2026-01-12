;; Define a function that returns the length of a multi-evel list,
;; i.e., the total number of atoms at any level

(DEFUN LG (L)
    (COND
        ((ATOM L) 1)
        (T (APPLY #'+ (MAPCAR #'LG L)))
    )
)
(write-line "6")
(write (LG '(1 (2 (a ) c d) (3))))