; problem 4 
; 1. 
(defun list-sum (l1 l2)
  (cond ((or (null l1) (null l2))
         nil)
        (t
         (cons (+ (car l1) (car l2))
               (list-sum (cdr l1) (cdr l2))
          )
        )
    )
)

; 2. 
(defun flatten (lst)
  (cond ((null lst) nil)
      ((atom (car lst))
        (cons (car lst) (flatten (cdr lst)))
      )
      (t 
        (append (flatten (car lst)) (flatten (cdr lst)))
      ) 
  )
)

; 3.
(defun collect-atoms (xs)
  (cond ((null xs) nil)
        ((atom (car xs))
         (cons (car xs) (collect-atoms (cdr xs))))
        (t nil)))

(defun drop-atoms (xs)
  (cond ((null xs) nil)
        ((atom (car xs)) (drop-atoms (cdr xs)))
        (t xs)))

(defun reverse-atom-runs (lst)
  (cond
    ((null lst) nil)

    ((atom (car lst))
     (let* ((atoms (collect-atoms lst))
            (rest  (drop-atoms lst)))
       (append (reverse atoms)
               (reverse-atom-runs rest))))

    (t (cons (reverse-atom-runs (car lst))
             (reverse-atom-runs (cdr lst))))))

; 4.
(defun max-top-level-numbers (lst)
  (cond ((null lst)
         nil)
        
        ((and (atom (car lst)) (numberp (car lst)))
         (let ((max-in-rest (max-top-level-numbers (cdr lst))))
           (cond ((null max-in-rest) 
                  (car lst))         
                 ((> (car lst) max-in-rest)
                  (car lst))         
                 (t 
                  max-in-rest))))    
        
        (t 
         (max-top-level-numbers (cdr lst))
        )
  )
)