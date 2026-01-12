; 13. Define a function that substitutes all instances an element with another in a multi level list

(defun subs(lst x y)
    (mapcar
        (lambda (e)
            (cond  
                ((listp e) (subs e x y))
                ((equal e x) y)
                (t e)
            )
            lst
        )
    ) 
) 