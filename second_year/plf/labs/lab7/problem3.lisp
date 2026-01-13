; Define a function that checks if an atom is a member of a multi level list
(defun member-list (lst e)
  (cond
    ((equal lst e) t)
    ((atom lst) nil)
    ((mapcan (lambda (x) (list (member-list x e))) lst) t)
    (t nil)
  )
)

(print (member-list '(A (B (C)) D) 'C))
