(define p1 '((2 1) (1 (- 2)) (0 1)))
(define p2 '((2 11) (0 7)))
(define p3 '((1 13) (0 5)))

(define q1 (mul p1 p2))
(define q2 (mul p1 p3))

(greatest-common-divisor q1 q2)
