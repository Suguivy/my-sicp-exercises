;; (+ (f 0) (f 1))

(define f
  (let ((n 0))
    (lambda (x)
      n
      (set! n x))))
