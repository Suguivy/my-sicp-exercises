(put 'negate '(scheme-number) -)
(put 'negate '(rational) (lambda (x) (make-rational (- (numer x))
                                                    (denom x))))
(put 'negate '(complex) (lambda (x) (make-complex (- (real-part x)
                                                  (- (imag-part x))))))

(define (negate x)
  (apply-generic 'negate x))

(define (negate-poly p)
  (make-poly (variable p)
             (map (lambda (x) (make-term (order x)
                                         (negate (coeff x))))
                  (term-list p))))

(define (substract-poly p1 p2)
  (add-poly p1 (negate-poly p2)))

(put 'negate-poly '(poly) negate-poly)
(put 'substract-poly '(poly poly) substract-poly)
