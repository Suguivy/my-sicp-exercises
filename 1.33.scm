(define (filtered-accumulate filter combiner null-value term a next b)
  (cond ((> a b) null-value)
    ((filter a) (combiner (term a) (filtered-accumulate filter combiner null-value term (next a) next b)))
    (else (filtered-accumulate filter combiner null-value term (next a) next b))))
; a
; Asumiendo que ya existe un procedimiento prime?
(define (prime-square-sum a b)
  (define (inc n) (+ n 1))
  (filtered-accumulate prime? + 0 square a inc b))

; b
(define (rel-prime-product n)
  (define (inc x) (+ x 1))
  (define (identity x) x)
  (define (rel-prime? x) (= (gcd x n) 1))
  (filtered-accumulate rel-prime? * 1 identity 2 inc n))
