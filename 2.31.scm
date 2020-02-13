(define nil '())

;; Without the built-in map procedure
(define (tree-map proc tree)
  (cond ((null? tree) nil)
        ((not (pair? tree) (proc tree)))
        (else (cons (tree-map proc (car tree))
                    (tree-map proc (cdr tree))))))

;; With the built-in map procedure
(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))
       tree))
