(define (make-center-percent c p)
  (let ((tolerance (* c (/ p 100))))
    (make-interval (- c tolerance)
		   (+ c tolerance))))

(define (lower-bound x)
  (car x))

(define (upper-bound x)
  (cdr x))

(define (center x)
  (/ (+ (lower-bound x) (upper-bound x))
     2))

(define (percent x)
  (let ((c (center x))
	(w (/ (abs (- (upeer-bound x) (upper-bound x))) 2)))
    (* (/ w c) 100)))
    
    
