(define (mul-streams a b)
  (stream-map * a b))

(define integers (integers-starting-from 1))

(define factorials (cons-stream 1 (mul-streams (stream-cdr integers) factorials)))

;; integers     {1 2 3 4 5 ...}
;;              *
;;              {1 1 2 6 24 ...}
;;              =
;; factorials   {1 2 6 24 120 ...}
