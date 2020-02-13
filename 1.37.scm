; a

(define (cont-frac n d k)
  (define (frac i)
    (if (= i k)
	(/ (n k) (d k))
	(/ (n i) (+ (d i) (frac (+ i 1))))))
  (frac 1))

;; k needs to be equal or larger than 11

; b

(define (cont-frac-iter n d k)
  (define (iter res i)
    (if (= i 0)
	res
	(iter (/ (n i)
		 (+ (d i) res))
	      (- i 1))))
  (iter 0 k))
