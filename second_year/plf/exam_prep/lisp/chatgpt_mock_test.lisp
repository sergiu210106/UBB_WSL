(defun count-atoms(lst) 
  (cond
    ((null lst) 0)
    ((atom L)
      (cond  
        ((numberp L) 1)
        (t 0)
      )
    )
    (t  
      (+ (count-atoms (car lst)) (count-atoms (cdr lst)))
    )
  )
)

(defun find-x (lst x)
  (cond
    ((null lst) nil)
    ((atom lst) 
      (cond
        ((equal lst x) t) 
        (t nil)
      )
    )
    (t (or (find-x (car lst) x) (find-x (cdr lst) x)))
  )
)

(defun list-nodes (lst k)
  (cond
    ((= k 0) (car lst))
    (t 
      (mapcan (lambda (c) (list-nodes c (- k 1)) (cdr lst)))
    )
  )
)

(defun sum-squares (lst)
  (cond  
    ((null lst) 0)
    ((atom lst)
      (cond
        ((numberp lst) (*  lst lst))
        (t 0)
      )
    )
    (t  
      (apply #'+ (mapcar #'sum-squares (lst)))
    )
  )
)

(defun count-atoms (lst)
  (cond  
    ((atom lst) 1)
    (t (apply #'+ (mapcar #'count-atoms lst)))
  )
)

(defun even-no-atoms (lst)
  (evenp (count-atoms lst))
)

(defun sum-odd (lst level)
  (cond  
    ((atom lst)
      (cond
        ((oddp level) (car lst))
        (t 0)
      )
    )
    (t apply #'+ (mapcar (lambda (c) (sum-odd c (+ level 1)) lst)))
  )
)
