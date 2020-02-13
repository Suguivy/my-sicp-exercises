(define rand
  (let ((r 0)) (lambda (action)
                 (cond ((eq? action 'generate) (set! r (rand-update r))
                                               r)
                       ((eq? action 'reset) (lambda (v) (set! r v)))))))

(define (rand-update x)
    (modulo (+ (* 923487829991287347891 x) 4382947932432742394983127) 1248934988293847398283219))
