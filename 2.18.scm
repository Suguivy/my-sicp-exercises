(define nil '())

(define (reverse l)
  (define (iter l rev-l)
    (if (null? l)
	rev-l
	(iter (cdr l) (cons (car l) rev-l))))
  (iter l nil))

;; Visto en solución:

(define (append l1 l2)
  (if (null? l1)
      l2
      (cons (car l1) (append (cdr l1) l2))))

(define (reverse-recursive l)
  (if (null? l)
      nil
      (append (reverse-recursive (cdr l)) (cons (car l) nil)))) 
