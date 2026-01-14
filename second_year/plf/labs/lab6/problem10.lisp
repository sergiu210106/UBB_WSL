; Given a type (2) tree, determine the level of a node x given that the root is at level 0.

(defun get-left (lst) (cadr lst))
(defun get-right (lst) (caddr lst))

(defun find-x (lst x)
    (cond  
        ((null lst) nil)
        ((equal x (car lst)) 0)
        (t  
            (cond  
                ((find-x (get-left lst) x)
                    (+ 1 (find-x (get-left lst) x))
                )
                ((find-x (get-right lst))
                    (+ 1 (find-x (get-right lst) x))
                ) 
                (t nil)
            )
        )
    )
)