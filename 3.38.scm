;; (define balance 100)

;; 1) Peter: (set! balance (+ balance 10))
;; 2) Paul:  (set! balance (- balance 20))
;; 3) Mary:  (set! balance (- balance (/ balance 2)))

;; a)
;; The posible combinations are:
;; 1-2-3: 45
;; 1-3-2: 35
;; 2-1-3: 45
;; 2-3-1: 50
;; 3-1-2: 40
;; 3-2-1: 40

;; b) For example, in the Mary withdrawal, balance is read two times, and its value may vary if the value is changed for other process.
