(define nil '())

(define (enumerate-interval a b)
  (if (> a b)
      nil
      (cons a
            (enumerate-interval (+ a 1) b))))

(define (unique-pairs n)
  (flatmap (lambda (i)
         (map (lambda (j) (list i j))
              (enumerate-interval 1 (- i 1))))
       (enumerate-interval 1 n)))
