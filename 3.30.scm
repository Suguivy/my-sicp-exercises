(define (ripple-carry-adder A B C S)
  (if (not (null? A))
      (let ((c-out (make-wire)))
        (full-adder (car A) (car B) C (car S) c-out)
        (ripple-carry-adder (cdr A) (cdr B) c-out (car S)))))

;; Delay of ripple-carry-delay is n * full-adder-delay
;; Delay of full-adder is 2 * half-adder-delay + or-gate-delay
;; Delay of half-adder delay is max(or-gate-delay, and-gate-delay + inverter-delay) + and-gate-delay
