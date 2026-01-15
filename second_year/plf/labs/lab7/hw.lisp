; 13. Define a function that substitutes all instances an element with another in a multi level list

(defun subs(lst x y)
    (mapcar
        (lambda (e)
            (cond  
                ((listp e) (subs e x y))
                ((equal e x) y)
                (t e)
            )
        )
        lst
    ) 
) 

(print (subs '(1 2 3 1) 1 10)) 
;; Output: (10 2 3 10)

(print (subs '(apple (orange apple) (banana (apple))) 'apple 'cherry))
;; Output: (cherry (orange cherry) (banana (cherry)))

(print (subs '(a b a) 'a '(1 2)))
;; Output: ((1 2) b (1 2))