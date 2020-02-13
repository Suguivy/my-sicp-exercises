; a
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (factorial n)
  (define (inc x) (+ x 1))
  (define (identity x) x)
  (product identity 1 inc n))

(define (pi-product n)
  (define (term a)
    (if (even? n)
	(/ n (+ n 1))
	(/ (+ n 1) n)))
  (define (inc n)
    (+ n 1))
  (* 4 (product term 2 inc (+ n 1))))

; b
(define (product-rec term a next b)
  (define (iter a res)
    (if (> a b)
	res
	(iter (next a) (* (term a) res))))
  (iter a 1))
