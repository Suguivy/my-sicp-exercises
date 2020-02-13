(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))
#|
(define a (list a b c))
(count-pairs a) -> 3
+-+-+ +-+-+ +-+-+
|a|*-->b|*-->c|/|
+-+-+ +-+-+ +-+-+

(define x (cons 'a 'b))
(define y (cons x x))
(define b (cons y 'c))
(count-pairs b) -> 4
+-+-+
|*|c|
+|+-+
 |
+v+-+
|*|*|
+|+|+
 | |
+v+v+
|a|b|
+-+-+

(define m (cons 'a 'b))
(define n (cons m m))
(define c (cons n n))
(count-pairs c) -> 7
+-+-+
|*|*|
+|+|+
 | |
+v+v+
|*|*|
+|+|+
 | |
+v+v+
|a|b|
+-+-+

(define d (list 'a 'b 'c))
(set-cdr! (cddr d) d)
(count-pairs d) -> Aborting!: maximum recursion depth exceeded
+-+-+ +-+-+ +-+-+
|a|*-->b|*-->c|*--+
+^+-+ +-+-+ +-+-+ |
 |                |
 +----------------+
|#
