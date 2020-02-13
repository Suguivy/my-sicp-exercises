(define (cont-frac n d k)
  (define (iter res i)
    (if (= i 0)
	res
	(iter (/ (n i) (+ (d i) res)) (- i 1))))
  (iter 0 k))

(define e (+ 2 (cont-frac (lambda (i) 1.0)
		     (lambda (i) (if (= 2 (remainder i 3))
					(/ (+ i 1) 1.5)
					1))
		     20)))
