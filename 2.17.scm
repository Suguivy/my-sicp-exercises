(define nil '())

(define (last-pair l)
  (let ((rest (cdr l)))
    (if (null? (cdr l))
	l
	(last-pair (cdr l)))))
