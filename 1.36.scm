(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 0.00001))
  (define (try guess)
    (let ((next (f guess)))
      (display guess)
      (newline)
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

; Without average damping
(define solution (fixed-point (lambda (x) (/ (log 1000) (log x))) 2))

; With average damping
(define (average a b) (/ (+ a b) 2))
(define solution (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 10.0))
