(put-coercion 'real 'complex (lambda (x)
			       (make-complex x 0)))

(put-coercion 'rational 'real (lambda (x)
				(make-real (/ (numer x) (denom x)))))

(put-coercion 'integer 'rational (lambda (x)
					 (make-rat x 1)))

(put 'raise '(real) (get-coercion 'real 'complex))
(put 'raise '(rational) (get-coercion 'rational 'real))
(put 'raise '(integer) (get-coercion 'integer 'rational))

(define (raise n)
  (apply-generic 'raise n))
