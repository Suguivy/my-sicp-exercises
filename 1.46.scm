(define (iterative-improve good-enough? improve)
  (define (f guess)
    (if (good-enough? guess)
	guess
	(f (improve guess))))
    f)

(define (sqrt x)
  ((iterative-improve
   (lambda (guess)
     (< (abs (- (square guess) x)) 0.001))
   (lambda (guess)
     (/ (+ guess (/ x guess))
	2))) 1.0))

(define (fixed-point f)
  ((iterative-improve
   (lambda (guess)
     (< (abs (- guess (f guess))) 0.00001))
   f) 1.0))
