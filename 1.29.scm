(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b n)
  (define (h) (/ (- b a) n))
  (define (y k) (f (+ a (* k (h)))))
  (define (term x)
    (cond ((= x 0) (y 0))
          ((= x n) (y n))
          ((even? x) (* 2 (y x)))
          (else (* 4 (y x)))))
  (define (next n) (+ n 1))
  (* (/ (h) 3)
     (sum term 0 next n)))

