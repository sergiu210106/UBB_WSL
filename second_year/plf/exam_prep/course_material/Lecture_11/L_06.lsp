;; Define a function that determines the number of appearances of an element in
;; a multi-level list

(defun fun(e L)
    (cond
        ((equal L e) 1)
        ((atom L) 0)
        (t (apply
                #'+
                (mapcar
                    #'(lambda(L) (fun e L))
                    L)
                )
        )
    )
)

(write-line "4")
(write (fun 'a '(1 (a (3 (4 a) a)) (7 (a 9)))))