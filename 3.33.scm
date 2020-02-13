(define (averager a b c)
  (let ((x (make-connector))
        (y (make-connector)))
    (constant 2 y)
    (multiplier c y x)
    (adder a b x)
    'ok))
