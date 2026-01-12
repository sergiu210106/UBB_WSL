(defun insert-at-even(lst e) 
    (cond
        ((null lst) nil)
        ((null (cdr lst)) lst) 
        (t
            (cons (car lst)
                (cons (cadr lst)
                    (cons e (insert-at-even (cddr lst) e))
                )
            )
        )
    )
)
(defun extract-reverse-helper(lst acc) 
    (cond 
        ((null lst) acc) 
        ((atom lst) (cons lst acc))
        (t 
            (extract-reverse-helper (cdr lst) (extract-reverse-helper (car lst) acc))
        )
    )
)

(defun extract-reverse (lst)
    (extract-reverse-helper(lst nil))
)

(defun count-occurences(lst e)
    (count-occurences-helper lst e 0)
)

(defun count-occurences-helper (lst e acc)
    (cond 
        ((null lst) acc)
        ((eq (car lst) e)
         (count-occurences-helper (cdr lst) e (+ 1 acc))
        )
        (t 
            (count-occurences-helper (cdr lst) e acc)
        )
    )
)

