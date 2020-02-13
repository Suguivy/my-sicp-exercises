; If 0 is on the divisor interval, an error occurs
(define (div-interval x y)
  (if (<= 0 (* (lower-bound y) (upper-bound y)))
      (error "Interval spans 0")
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
		      (/ 1.0 (lower-bound y)))))
