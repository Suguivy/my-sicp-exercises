(define (fringe l)
  (cond ((null? l) '())
        ((pair? l) (append (fringe (car l)) (fringe (cdr l))))
        (else (list l))))
