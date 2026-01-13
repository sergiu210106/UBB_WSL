; Define a function that determines the number of nodesat level k in a n-ary tree (< value > < subtree1 > ... < subtreeN>). E.g. (a (b (c)) (d) (e (f))), k=1 →3

(defun count-nodes-at-level (tree k)
  (cond ((null tree) 0)
        ((= k 0) 1)
        ((atom tree) 0) 
        (t (apply #'+ (mapcar (lambda (child) 
                                (count-nodes-at-level child (- k 1))) 
                              (cdr tree))))))

(print (count-nodes-at-level '(a (b (c)) (d) (e (f))) 1))