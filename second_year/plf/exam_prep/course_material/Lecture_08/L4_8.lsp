; Define a function that takes a list and retuns a pair of lists, the first one
; containing the first k elements, and the second containing the rest

(defun iterate_aux(L k col)
    (cond
        ((null L) nil)
        ((= k 0) (list col L))
        (t (iterate_aux (cdr L) (- k 1) (cons (car l) col)))
    )
)

(defun iterate (L k)
    (iterate_aux L k nil)
)

(write (iterate '(1 2 3 4 5) 3))