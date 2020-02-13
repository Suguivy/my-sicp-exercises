(define (install-complex-package)
  ...
  (define (=zero? a)
    (and (= (real-part a) (imag-part a) 0)))
  (put '=zero? '(complex) =zero?)
  ...)

(define (install-scheme-number-package)
  ...
  (define (=zero? a)
    (= a 0))
  (put 'zero=? '(scheme-number) =zero?)
  ...)

(define (install-rational-package)
  ...
  (define (=zero? a)
    (= (numer a) 0))
  (put '=zero? '(rational) =zero?)
  ...)

(define (=zero? a) (apply-generic '=zero? a))
