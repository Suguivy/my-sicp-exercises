(define (split proc1 proc2)
  (define combined-proc (lambda (painter) (proc1 painter (proc2 painter painter))))
  (define (recurse painter n)
    (if (= n 0)
        painter
        (recurse (combined-proc painter) (- n 1))))
  recurse)
