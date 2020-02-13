(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

#|
+-----+ +-----+ +-----+
|'a| *-->'b| *-->'c| *--+
+^----+ +-----+ +-----+ |
 |                      |
 +----------------------+
|#

;; If we try to compute this, the interpreter will be in an infinite loop, because (last-pair x) is never null.
