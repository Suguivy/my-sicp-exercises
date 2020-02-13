(define (make-accumulator init)
  (lambda (add)
    (begin (set! init (+ init add))
           init)))
