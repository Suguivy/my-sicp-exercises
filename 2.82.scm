(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (try-apply args op type-tags type-tags)))))

(define (can-coerce-to? types type)
    (cond ((null? types) true)
	  ((or (get-coercion (car types) type)
	       (eq? (car types) type)) (can-coerce-to? (cdr types) type))
	  (else false)))

(define (try-apply args op types to-types)
  (cond ((null? args) (error "No method for these types"))
	((can-coerce-to? types (car to-types)) (apply-generic op (map (lambda (x)
									(if (eq? (type-tag x) (car to-types))
									    x
									    ((get-coercion (type-tag x) (car-to-types)) x))
									args))))
	(else (try-apply args op types (cdr to-types)))))

;; Example: a procedure that takes a complex and a rational but both of the arguments are integers
