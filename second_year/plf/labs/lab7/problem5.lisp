; Define a function that checks if a node of an n-ary tree (< value > < subtree1 > ... <subtreeN>). E.g. (a (b (c)) (d) (e (f))), ’b →T

(defun find-node(lst e)
    (cond  
        ((equal lst e) t)
        ((atom lst) nil)
        ((mapcan (lambda (c) 
            (cond  
                ((find-node c e) (list t))
                (t nil)
            )) lst) t)
        (t nil)
    )
)

(print (find-node '(a (b (c)) (d) (e (f))) 'b))
(print (find-node '(a (b (c)) (d) (e (f))) 'x))