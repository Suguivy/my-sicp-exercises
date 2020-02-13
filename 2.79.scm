(define (install-complex-package)
  ...
  (define (equ? a b)
    (and (= (real-part a) (real-part b))
	 (= (imag-part a) (imag-part b))))
  (put 'equ? '(complex complex) equ?)
  ...)

(define (install-scheme-number-package)
  ...
  (put 'equ? '(scheme-number scheme-number) =)
  ...)

(define (install-rational-package)
  ...
  (define (equ? a b) ;; Rational numbers are always simplified: we can simply compare if numer and denom of the numbers are equal
    (and (= (numer a) (numer b))
	 (= (denom a) (denom b))))
  (put 'equ? '(rational rational) equ?)
  ...)

(define (equ? a b)
  (apply-generic 'equ? a b))
