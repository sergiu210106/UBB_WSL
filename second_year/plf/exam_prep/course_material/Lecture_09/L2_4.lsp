; Given a set represented as a list, produce the list of all its permutations

(DEFUN INS (E N L)
    (COND
        ((= N 1) (CONS E L))
        (T (CONS (CAR L) (INS E (- N 1) (CDR L))))
    )
)

(DEFUN INSERT_AUX (E N L)
    (COND
        ((= N 0) NIL)
        (T (CONS (INS E N L) (INSERT_AUX E (- N 1) L)))
    )
)

(DEFUN INSERT (E L)
    (INSERT_AUX E (+ (LENGTH L) 1) L)
)

(WRITE (INS '1 2 '(2 3)))
(WRITE-LINE "")
(WRITE (INS '1 3 '(2 3)))
(WRITE-LINE "")
(WRITE (INSERT_AUX '1 2 '(2 3)))
(WRITE-LINE "")
(WRITE (INSERT '1 '(2 3)))