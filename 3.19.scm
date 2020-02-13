;; Falla si la lista se compone de un elemento
(define (is-cycle x)
  (define (iter slow fast)
    (cond ((eq? slow fast) true)
          ((or (null? (cdr fast)) (null? (cddr fast))) false)
          (else (iter (cdr slow) (cddr fast)))))
  (iter x (cdr x)))
