(set 'a '(1 2 3 4))
(set (quote b) (list 1 2 3 4))
(setq c '(1 2 3 4))

(print a)
(print b)
(print c)

(setf (cadr c) 6)
(print c)

