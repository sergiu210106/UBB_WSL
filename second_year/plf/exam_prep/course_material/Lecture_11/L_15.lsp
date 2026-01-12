;;  define a function that multiplies two matrices represented as a list of
;;  equal length lists

(DEFUN TRANSPOSE (L)
    (COND
        ((NULL (CAR L)) NIL)
        (T (CONS (MAPCAR #'CAR L) (TRANSPOSE (MAPCAR #'CDR L))))
    )
)

(DEFUN TRANSPOSE_MUL (L1 L2)
    (COND
    ((NULL (CAR L1)) NIL)
        (T (CONS
                (MAPCAR
                    #'(LAMBDA (L)
                        (APPLY #'+ (MAPCAR #'* (CAR L1) L))
                    )
                    L2
                )
                (TRANSPOSE_MUL (CDR L1) L2)
        ))
    )
)

(DEFUN MAT_MUL (L1 L2)
    (TRANSPOSE_MUL L1 (TRANSPOSE L2))
)

(write-line "((8 1) (18 1))")
(write (MAT_MUL '((1 2) (3 4)) '((2 -1) (3 1))))