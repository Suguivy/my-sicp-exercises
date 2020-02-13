(define (square-list items)
  (if (null? items)
      nil
      (cons (square (car items) (square-list (cdr items))))))

(define (square-list items)
  (map square items))
