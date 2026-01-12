; Define a function that pushes an element to the end of a list

(defun my_append (e l)
    (cond
        ((null l) (list e))
        (t (cons (car l) (my_append e (cdr l))))
    )
)
(write (my_append '3 '(1 2)))
(write-line "")
(write (my_append '(3) '(1 2)))
(write-line "")
(write (my_append '3 '()))