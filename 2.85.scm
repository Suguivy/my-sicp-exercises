(put 'project '(complex) real-part)
(put 'project '(real) round)
(put 'project '(rational) numer)

(define (project x)
  (apply-generic 'project x))

(define (drop x)
  (if (equ? (raise (project x)) x)
      (drop (project x))
      x))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (if (= (length args) 2)
	      (let ((a1 (car args))
		    (a2 (cadr args)))
		(if (equal? (higher-type a1 a2) a1)
		    (drop (apply-generic op a1 (raise-to a2 (type-tag a1))))
		    (drop (apply-generic op (raise-to a1 (type-tag a2)) a2)))
	      (error "No method for these types"
		     (list op type-tags)))))))

(define (higher-type a b)
  (if (eq? (type-tag a) (type-tag b))
      b
      (let ((proc (get 'raise '(type-tag a))))
	(if proc
	    (higher (proc a) b)
	    a))))

(define (raise-to x type)
  (if (eq? (type-tag x) type)
      x
      (raise-to (raise x) (type))))
