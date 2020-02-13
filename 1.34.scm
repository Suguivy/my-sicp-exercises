(define (f g) (g 2))

(f square)
(f (lambda (z) (* z (+ z 1))))

(f f)

; It will evaluate:
; (f f)
; (f 2)
; (2 2)
; And evaluating (2 2) throws an error
