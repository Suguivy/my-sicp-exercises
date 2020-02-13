(define (below painter1 painter2)
  (let ((split-point (make-vector 0 0.5)))
    (let ((paint-bottop (transform-painter
		       painter1
		       (make-vector 0 0)
		       (make-vector 1 0)
		       split-point))
	  (paint-top (transform-painter
		     painter2
		     split-point
		     (make-vector 1 0.5)
		     (make-vector 0 1))))
      (lambda (frame)
	(paint-bottom frame)
	(paint-top frame)))))

;; In terms of rotate definition of Exercise 2.50
(define (below painter1 painter2)
  (rotate270 (beside (rotate270 (rotate180 painter1))
		     (rotate270 (rotate180 painter2)))))
