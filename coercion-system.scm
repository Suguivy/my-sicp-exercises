;; Creates the coercion table
;; The table is defined as following: ((to1 (td1 . proc1) (td2 . proc2) ...) (to2 (td1 . proc1) (td2 . proc2) ...) ...)
(define coercion-table '())

;; Puts in the coercion-table the item in the t1-t2 cell. It doesn't check duplicates
(define (put-coercion t1 t2 item)
  (let ((new-entrie (list t1 (cons t2 item))))
    (define (iter table)
      (cond ((equal? (caar table) t1) (set-cdr! (car table) (cons (cadr new-entrie)
								    (cdar table))))
	    ((null? (cdr table)) (set-cdr! table (list new-entrie)))
	    (else (iter (cdr table)))))
    (if (null? coercion-table)
	(set! coercion-table (list new-entrie))
	(iter coercion-table))))

;; returns the procedure matching the specified t1->t2 coercion
(define (get-coercion t1 t2)
  (define (iter table)
    (define (search-t2 lst)
      (cond ((null? lst) (error "The data cannot be converted to the specified type: GET-COERCION" t1 t2))
	    ((eq? (caar lst) t2) (cdar lst))
	    (else (search-t2 (cdr lst)))))
    (cond ((null? table) (error "Invalid type: GET-COERCION" t1 t2))
	  ((equal? (caar table) t1) (search-t2 (cdar table)))
	  (else (iter (cdr table)))))
  (iter coercion-table))

(put-coercion 'scheme-number 'complex (lambda (x)
			       (make-complex-from-real-imag x 0)))
(put-coercion 'rational 'scheme-number (lambda (x)
				(make-scheme-number (div (numer x) (denom x)))))
(put 'raise 'scheme-number (get-coercion 'scheme-number 'complex))
(put 'raise 'rational (get-coercion 'rational 'scheme-number))

(put 'project 'complex real-part)
(put 'project 'scheme-number (lambda (x) (make-rational (round x) 1)))

(define (raise n)
  (let ((proc (get 'raise (type-tag n))))
    (if proc
        (proc n)
	n)))
  
(define (apply-generic op . args)
  (display (list op args))
  (newline)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (if (= (length args) 2)
	      (let ((a1 (car args))
		    (a2 (cadr args)))
		(if (equal? (higher-type a1 a2) a1)
		    (apply-generic op a1 (raise-to a2 (type-tag a1)))
		    (apply-generic op a2 (raise-to a1 (type-tag a2)))))
	      (error "No method for these types"
		     (list op type-tags args)))))))

(define (higher-type a b)
  (define (iter x)
    (if (eq? (type-tag x) (type-tag b))
	b
	(let ((proc (get 'raise (type-tag x))))
	  (if proc
	      (iter (proc x))
	      a))))
  (iter a))

(define (raise-to x type)
  (if (eq? (type-tag x) type)
      x
      (raise-to (raise x) type)))

(define (drop x)
  (let ((project (get 'project (type-tag x))))
    (if (and project (equ? (raise (contents (project (contents x)))) x))
	(drop (project x))
	x)))
