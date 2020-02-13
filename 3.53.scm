(define s (cons-stream 1 (add-streams s s)))
;; This stream generates the powers of 2: {1 2 4 8 16 32 64 ...}
