(defun my_apply (fun param_list)
    (eval
        (cons fun param_list)
    )
)

(print (apply '+ '(1 2 3)))
(print (my_apply '+ '(1 2 3)))

(defun my_mapcar (fun lst)
    (cond
        ((null lst) nil)
        (t (cons (funcall fun (car lst)) (my_mapcar fun (cdr lst))))
    )
)

(print (mapcar #'(lambda (x) (+ (car x) (cadr x))) '((1 2) (3 4) (5 6))))
(print (my_mapcar #'(lambda (x) (+ (car x) (cadr x))) '((1 2) (3 4) (5 6))))