;; Abstraction
(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))

;; Operations
(define (add-vect v1 v2)
  (cons (+ (xcor-vect v1) (xcor-vect v2))
        (+ (ycor-vect v1) (ycor-vect v2))))
(define (sub-vect v1 v2)
  (cons (- (xcor-vect v1) (xcor-vect v2))
        (- (ycor-vect v1) (ycor-vect v2))))
(define (scale-vect s v)
  (cons (* s (xcor-vect v))
        (* s (ycor-vect v))))

(define (alt-sub-vect v1 v2)
  (add-vect v1
            (scale-vect -1 v2)))
