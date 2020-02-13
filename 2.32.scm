(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (set)
                            (cons (car s) set))
                          rest)))))

;; That works because we are taking a number out of s and appending the resulting list to s. If we continue until we reach the base case, we will have all subsets.
