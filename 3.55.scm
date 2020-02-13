(define (partial-sums s)
  (add-streams s
               (stream-cons 0 (partial-sums s))))

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s)
                            (partial-sums s))))
