;; a. in terms of mutexes
(define (make-semaphore n)
  (let ((mutex (make-mutex)) ;; Controls which process is being managed by the semaphore
        (count 0)) ;; Controls how many process are running
    (define (acquire)
      (mutex 'acquire)
      (if (= count n)   ; if already have n processes acquiring the semaphore
          (begin (mutex 'release)
                 (acquire))    ; acquire again
          (begin (set! count (+ count 1))
                 (mutex 'release))))
    (define (release)
      (mutex 'acquire)
      (set! count (- count 1))
      (mutex 'release))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (acquire))
            ((eq? m 'release)
             (release))))
    the-semaphore))


;; b. in terms of atomic test-and-set! operations
(define (make-semaphore n)
  (let ((cell (list false))
        (count 0))
    (define (acquire)
      (acquire-cell)
      (if (= count n)
          (begin (clear! cell)
                 (acquire))
          (begin (set! count (+ count 1))
                 (clear! cell))))
    (define (release)
      (acquire-cell)
      (set! count (- count 1))
      (clear! cell))
    (define (acquire-cell)
      (if (test-and-set! cell)
          (acquire-cell)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (acquire))
            ((eq? m 'release)
             (release))))
    the-semaphore))

;; From https://github.com/qiao/sicp-solutions/blob/master/chapter3/3.47.scm
