;; Define a function that takes a multi-level list and returns the number of
;; sublists, including itself, who's length is even

(DEFUN EVEN (L)
    (COND
        ((= 0 (MOD (LENGTH L) 2)) T)
        (T NIL)
    )
)
(DEFUN nbr (L)
    (COND
        ((ATOM L) 0)
        ((EVEN L) (+ 1 (APPLY #'+ (MAPCAR #'nbr L))))
        (T (APPLY #'+ (MAPCAR #'nbr L)))
    )
)
(write-line "4")
(write (nbr '(1 (2 (3 (4 5) 6)) (7 (8 9)))))