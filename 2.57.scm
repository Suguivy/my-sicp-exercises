(define (binary-expression? e)
  (null? (cdddr e)))

(define (second-term e)
  (caddr e))
 
(define (all-but-first-term e)
  (cddr e))

(define (reduce-expression e op)
  (if (binary-expression? e)
      (second-term e)
      (cons op (all-but-first-term e))))
 
(define (augend s) (reduce-expression s '+))
 
(define (multiplicand p) (reduce-expression p '*))
