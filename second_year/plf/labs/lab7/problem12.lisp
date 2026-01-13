; 12. Define a function that substitutes a node with another in an n-ary tree (< value > < subtree1 > ... < subtreeN>). E.g. (a (b (c)) (d) (e (f))), ’b, ’g →(a (g (c)) (d) (e (f)))

(defun subs(lst x y)
    (cond  
        ((equal lst x) y)
        ((atom lst) lst)
        (t  
            (mapcar (lambda (c) (subs c x y)) lst)
        )
    )
)

(print (subs '(1 (2 3) 2) '2 '5))