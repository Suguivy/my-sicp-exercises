(define (adjoin-term-sparse term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))
(define (adjoin-term-dense term term-list)
    (let ((term-order (order term))
          (first-term-order (order (first-term term-list))))
          (cond ((=zero? (coeff term)) term-list)
                ((> term-order first-term-order) (adjoin-term term (cons 0 term-list)))
                ((< term-order first-term-order) (cons (car term-list)                                                                                                   (adjoin-term term (cdr term-list))))
                (else (cons (+ (coeff term) (car term-list)) (cdr term-list))))))

(put '(sparse) 'adjoin-term adjoin-term-sparse)
(put '(sparse) 'first-term car)
(put '(dense) 'adjoin-term adjoin-term-dense)
(put '(dense) 'first-term (lambda (l) (list (car l) (- (length l) 1))))

(define (adjoin-term term term-list)
  (apply-generic 'adjoin-term term term-list))

(define (first-term term-list)
  (apply-generic 'first-term term-list))
