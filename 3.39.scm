(define x 10)
(define s (make-serializer))
(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
                  (s (lambda () (set! x (+ x 1)))))
;; Possible values:
;; 101 - Yes
;; 121 - Yes
;; 110 - No
;; 11 -  Yes
;; 100 - Yes
