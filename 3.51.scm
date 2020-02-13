;; (define x (stream-map show (stream-enumerate-interval 0 10))) -> 0 (only the car of `x' is computed)
;; (stream-ref x 5) -> 12345 (the 0 is already memoized when `stream-ref' calls `stream-cdr')
;; (stream-ref x 7) -> 67 (the same as above)
