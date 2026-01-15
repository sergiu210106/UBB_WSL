; mirror a tree in type 1

(defun get-left (lst)
    (get-subtree (cddr lst) 0 0)
)

(defun get-subtree (lst nodes edges)
    (cond  
        ((null lst) nil)
        ((= (+ edges 1) nodes) nil)
        (t  
            (cons (car lst) 
                (cons (cadr lst)
                    (get-subtree (cddr lst) (+ nodes 1) (+ edges (cadr lst)))
                )
            )
        )
    )
)

(defun get-right (lst)
    (skip (cddr lst) 0 0)
)

(defun skip (lst nodes edges)
    (cond  
        ((null lst) nil)
        ((= (+ edges 1) nodes) lst)
        (t   
            (skip (cddr lst) (+ nodes 1) (+ edges (cadr lst)))
        )
    )
)

(defun mirror (lst)
    (cond  
        ((null lst) nil)
        (t  
            (cons (car lst)
                (cons (cadr lst)
                    (append (mirror (get-right lst)) (mirror (get-left lst)))
                )
            )
        )
    )
)

(write "(write (mirror '(a 2 b 2 d 0 e 0 c 0)))             -->             ")

(write (mirror '(a 2 b 2 d 0 e 0 c 0)))

(write "            ***should be (a 2 c 0 b 2 e 0 d 0)")