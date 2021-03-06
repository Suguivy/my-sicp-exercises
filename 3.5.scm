(define (pi-estimate)
  (let ((radius 50))
    (/ (estimate-integral (make-circle-pred 50 50 radius) 0 100 0 100 1000000)
       (square radius))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (* (monte-carlo trials (lambda () (P (random-in-range x1 (+ x2 1)) (random-in-range y1 (+ x2 1)))))
     (* (- x2 x1) (- y2 y1))))

(define (make-circle-pred center-x center-y radius)
  (lambda (x y) (<= (+ (square (- x center-x)) (square (- y center-y))) (square radius))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else (iter (- trials-remaining 1)
                      trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))
