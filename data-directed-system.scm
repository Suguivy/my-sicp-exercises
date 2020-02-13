;; Creates the data directed programming table
;; The table is defined as following: ((t1 (op1 . proc1) (op2 . proc2) ...) (t2 (op1 . proc1) (op2 . proc2) ...) ...)
(define op-table '())

;; Puts in the op-table the item in the type-op cell. It doesn't check duplicates
(define (put op type item)
  (let ((new-entrie (list type (cons op item))))
    (define (iter table)
      (cond ((equal? (caar table) type) (set-cdr! (car table) (cons (cadr new-entrie)
								    (cdar table))))
	    ((null? (cdr table)) (set-cdr! table (list new-entrie)))
	    (else (iter (cdr table)))))
    (if (null? op-table)
	(set! op-table (list new-entrie))
	(iter op-table))))

;; returns the procedure matching the specified op and type
(define (get op type)
  (define (iter table)
    (define (search-op lst)
      (cond ((null? lst) false) ;; opeeration not found
	    ((eq? (caar lst) op) (cdar lst))
	    (else (search-op (cdr lst)))))
    (cond ((null? table) false) ;; types not found
	  ((equal? (caar table) type) (search-op (cdar table)))
	  (else (iter (cdr table)))))
  (iter op-table))

(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
	((number? datum) 'scheme-number)
	(error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (cond ((pair? datum) (cdr datum))
	((number? datum) datum)
	(error "Bad tagged datum: CONTENTS" datum)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (error "No method for these types: APPLY-GENERIC" (list op type-tags))))))

(define (make-from-real-imag x y)
((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))
(define (numer x) (apply-generic 'numer x))
(define (denom x) (apply-generic 'denom x))
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) ((get 'equ? (list (type-tag x) (type-tag y))) (contents x) (contents y)))
(define (=zero? a) (apply-generic '=zero? a))

(install-polar-package)
(install-rectangular-package)
(install-complex-package)
(install-scheme-number-package)
(install-rational-package)
