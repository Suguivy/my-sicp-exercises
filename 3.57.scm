(define (fibgen a b) (cons-stream a (fibgen b (+ a b))))
(define fibs (fibgen 0 1))

;; fibs : {0 1 1 2 3 5 8 ...}
;; With memoizing: one more sum for each number
;; Without memoizing: ...
