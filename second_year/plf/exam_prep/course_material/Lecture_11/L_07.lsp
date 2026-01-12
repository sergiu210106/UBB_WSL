;; Define a function that takes a multi-level list and returns the lists after
;; deleting all negaive numbers

(defun del(L)
    (cond
        ((and (numberp L) (minusp L)) nil)
        ((atom L) (list L))
        (t (list
            (apply
                #'append
                (mapcar #'del L)
            )
        ))
    )
)

(write-line "(((A) (C)))")
(write (del '((a) (c -2))))
(write-line "")
(write-line "((A))")
(write (del '(a)))
(write-line "")
(write-line "((C))")
(write (del '(c -2)))
(write-line "")
(write-line "(A A)")
(write (nconc '(a) '(c)))
(write-line "")
(write-line "((A) (C))")
(write (nconc '((a)) '((c))))
(write-line "")

(defun mydelete(L)
    (car (del L))
)

(write-line "(a 2 (b (c)))")
(write (mydelete '(a 2 (b -4 (c -6)) -1)))