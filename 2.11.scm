; Old mul-interval
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))

; New mul-interval
(define (mul-interval x y)
  (let ((lx (min (lower-bound x) (upper-bound x)))
	(ux (max (lower-bound x) (upper-bound x)))
	(ly (min (lower-bound y) (upper-bound y)))
	(uy (max (lower-bound y) (upper-bound y))))
    (if (>= lx 0)
	(cond ((>= ly 0) (make-interval (* lx ly) (* ux uy)))
	      ((>= uy 0) (make-interval (* ux ly) (* ux uy)))
	      (else (make-interval (* ux ly) (* lx uy))))
	(if (>= ux 0)
	    (cond ((>= ly 0) (make-interval (* lx uy) (* ux uy)))
		  ((>= uy 0) (make-interval (min (* lx uy) (* ux ly)) (max (* lx ly) (* ux uy))))
		  (else (make-interval (* ux ly) (* lx ly))))
	    (cond ((>= ly 0) (make-interval (* lx uy) (* ux ly)))
		  ((>= uy 0) (make-interval (* lx uy) (* lx ly)))
		  (else (make-interval (* ux uy) (* lx ly))))))))
		
; [+, +] * [+, +] = [lx * ly, ux * uy]
; [+, +] * [-, +] = [ux * ly, ux * uy]
; [+, +] * [-, -] = [ux * ly, lx * uy]	    
; [-, +] * [+, +] = [lx * uy, ux * uy]
; [-, +] * [-, +] = [min(lx * uy, ux * ly), max(lx * ly, ux * uy)]
; [-, +] * [-, -] = [ux * ly, lx * ly)
; [-, -] * [+, +] = [lx * uy, ux * ly]
; [-, -] * [-, +] = [lx * uy, lx * ly]
; [-, -] * [-, -] = [ux * uy, lx * ly]
