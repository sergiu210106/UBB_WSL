; Define a function that returns the height of an n-ary tree (< value > < subtree1 > ... <
; subtreeN>). a (a (b (c)) (d) (e (f))) →3

(defun height (tree)
    (cond  
        ((atom tree) 0)
        (t  
            (+ 1 (apply #'max (mapcar #'height tree)))
        )
    )
)

(print (height '(a (b (c)) (d) (e (f)))))