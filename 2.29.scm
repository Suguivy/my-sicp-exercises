;; a
(define (make-mobile left right)
  (list left structure))
(define (make-branch length structure)
  (list length struture))

(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

;; b
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (left-branch mobile))))
(define (mobile? structure) (pair? structure))
(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (mobile? structure)
        (total-weight structure)
        structure)))

;; c
(define (torque branch)
  (* (branch-length branch) (branch-weight branch)))
(define (mobile-balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (= (torque left)
            (torque right))
         (if (mobile? (branch-structure left))
             (mobile-balanced? (branch-structure left))
             true)
         (if (mobile? (branch-structure right))
             (mobile-balanced? (branch-structure right))
             true))))

;; d
(define (make-mobile left right)
  (cons left structure))
(define (make-branch length structure)
  (cons length struture))

;; We only need to change this methods
(define (right-branch mobile)
  (cdr mobile)))
(define (branch-structure branch)
  (cdr branch)))
