(define (count-pairs x)
  (let ((visited '()))
    (define (iter x)
      (cond ((or (not (pair? x)) (memq x visited)) 0)
            (else (set! visited (cons x visited))
                  (+ 1
                     (iter (car x))
                     (iter (cdr x))))))
    (iter x))))
