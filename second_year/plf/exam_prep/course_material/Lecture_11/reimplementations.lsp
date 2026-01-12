(defun my_apply (fun param_list)
    (eval
        (cons fun param_list)
    )
)

(print (apply '+ '(1 2 3)))
(print (my_apply '+ '(1 2 3)))

(defun my_funcall (fun &rest param_list)
    (my_apply fun param_list)
)

(print (funcall '+ '1 2 3))
(print (my_funcall '+ '1 2 3))

(defun zip (&rest param_list) ;(zip (a b) (c d)) --> param_list = ((a b) (c d))
    (cond
        ((null param_list) nil)
        ((not (every #'(lambda (x) x) (mapcar #'listp param_list))) nil)
        ((not (every #'(lambda (x) x) (mapcar #'(lambda (x) (not (null x))) param_list))) nil)
        (t (cons (mapcar #'car param_list) (apply #'zip (mapcar #'cdr param_list))))
    )
)
(print (zip))
(print (zip '(a b) 'c))
(print (zip '(a b) '()))
(print (zip '(a b) '(c d)))
(print (zip '(a b)))



(defun my_mapcar (fun lst)
    (cond
        ((null lst) nil)
        (t (cons (funcall fun (car lst)) (my_mapcar fun (cdr lst))))
    )
)

(print (mapcar #'(lambda (x) (+ (car x) (cadr x))) '((1 2) (3 4) (5 6))))
(print (my_mapcar #'(lambda (x) (+ (car x) (cadr x))) '((1 2) (3 4) (5 6))))

(defun fun (x)
    (cond
        ((= x 0) nil)
        (t (cons x (fun (- x 1))))
    )
)

(defun my_mapcan (fun lst)
    (apply #'nconc (my_mapcar fun lst))
)
(print (mapcan #'fun '(1 2 3 4) ))
(print (my_mapcan #'fun '(1 2 3 4) ))

(defun fun2 (x) (apply '+ x))

(defun my_maplist (fun lst)
    ; (print lst)
    (cond
        ((null lst) nil)
        (t (cons (funcall fun lst) (my_maplist fun (cdr lst))))
    )
)

(print (maplist #'fun2 '(1 2 3 4) ))
(print (my_maplist #'fun2 '(1 2 3 4) ))

(defun fun3 (x) (mapcar #'fun x))

(defun my_mapcon (fun lst)
    (apply #'nconc (my_maplist fun lst))
)

(print (my_mapcon #'fun3 '(1 2 3 4)))
(print (mapcon #'fun3 '(1 2 3 4)))