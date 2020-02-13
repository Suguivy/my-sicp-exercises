(define (remainder-terms L1 L2)
  (cdr (div-terms L1 L2)))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (gcd-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (gcd-terms (term-list p1) (term-list p2)))))

(put 'gcd '(poly poly) gcd-poly)

(define (greatest-common-divisor a b)
    (apply-generic 'gcd a b))
