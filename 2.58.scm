(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) (if (same-variable? exp var) 1 0))
	((product? exp)
	 (make-sum
	  (make-product (multiplier exp)
			(deriv (multiplicand exp) var))
	  (make-product (deriv (multiplier exp) var)
			(multiplicand exp))))
	((sum? exp) (make-sum (deriv (addend exp) var)
			      (deriv (augend exp) var)))
	(else
	 (error "unknown expression type: DERIV" exp))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2))
	 (+ a1 a2))
	(else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) (* m1 m2))
	(else (list m1 '* m2))))

(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s) (cddr s))

(define (product? x) (and (pair? x) (eq? (cadr x) '*)))

(define (product? x)
  (cond ((not (pair? x)) false)
	((eq? (car x) '*) true)
	(else (product? (cdr x)))))

(define (multiplier p) (car p))

(define (multiplicand p) (cddr p))

(define (=number? exp num) (and (number? exp) (= exp num)))

;; a
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2))
	 (+ a1 a2))
	(else (list a1 '+ a2))))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) (* m1 m2))
	(else (list m1 '* m2))))
(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
(define (addend s) (car s))
(define (product? x) (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))

;; b
(define (operator? exp)
  (and (symbol? exp)
       (or (eq? exp '+)
	   (eq? exp '*))))
(define (low-operator op1 op2)
  (if (< (priority op1) (priority op2))
      op1
      op2))
(define (priority op)
  (cond ((eq? op '+) 0)
	((eq? op '*) 1)))
(define (min-operator x op)
  (define (iter 
  (cond ((null? x) false)
	((operator? (car x)) (min-operator (low-operator (car x) op)
  
(define (sum? x) (and (pair? x) (min-operator x '+)))
(define (augend s) (cddr s))
(define (product x) (and (pair? x) (min-operator x '*)))
(define (multiplicand p) (cddr p))

;; Sin terminar
