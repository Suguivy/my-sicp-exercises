(define (average a b) (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define (fast-expt b n)
  (cond ((= n 0) 1)
	((even? n) (square (fast-expt b (/ n 2))))
	(else (* b (fast-expt b (- n 1))))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (<= n 1)
      f
      (compose f (repeated f (- n 1)))))

(define (floor-log2 n)
  (define (iter m count)
    (if (= m 0)
        (- count 1)
        (iter (arithmetic-shift m -1) (inc count))))
  (iter n 0))

(define (root-index i x)
  (fixed-point ((repeated average-damp (floor-log2 n)) (lambda (y) (/ x (fast-expt y (- i 1))))) 1.0))
