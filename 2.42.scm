(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
	(list empty-board)
	(filter ; todas las posiciones
	 (lambda (positions) (safe? k positions))
	 (flatmap ; Todas las posiciones (ya están filtradas excepto la última columna calculada)
	  (lambda (rest-of-queens)
	    (map (lambda (new-row) ; Todas las posiciones posibles en la última columna calculada
		   (adjoin-position
		    new-row k rest-of-queens))
		 (enumerate-interval 1 board-size)))
	  (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (adjoin-position row col positions)
  (cons (list row col)
        positions))

(define empty-board '())

(define (get-row queen) (car queen))
(define (get-col queen) (cadr queen))

(define (safe? col positions)
  (let ((last-queen (car positions))
        (remaining-queens (cdr positions)))
    (define (queens-check? q1 q2)
      (or (= (get-row q1) (get-row q2))
          (= (get-col q1) (get-col q2))
          (= (abs (- (get-row q1) (get-row q2)))
             (abs (- (get-col q1) (get-col q2))))))
          
    (define (check-queen remaining)
      (cond ((null? remaining) true)
            ((queens-check? last-queen (car remaining)) false)
            (else (check-queen (cdr remaining)))))

    (check-queen remaining-queens)))
