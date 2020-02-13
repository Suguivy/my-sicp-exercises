;; a
(segments->painter
  ((make-segment (make-vector 0 0) (make-vector 0 1))
   (make-segment (make-vector 0 1) (make-vector 1 1))
   (make-segment (make-vector 1 1) (make-vector 1 0))
   (make-segment (make-vector 1 0) (make-vector 0 0))))

;; b
(segments->painter
  ((make-segment (make-vector 1 0) (make-vector 0 1))
   (make-segment (make-vector 1 1) (make-vector 0 0))))

;; c
(segments->painter
  ((make-segment (make-vector 0   0.5) (make-vector 0.5 1))
   (make-segment (make-vector 0.5 1)   (make-vector 1   0.5))
   (make-segment (make-vector 1   0.5) (make-vector 0.5 0))
   (make-segment (make-vector 0.5 0)   (make-vector 0   0.5))))

;; d
;; Habría que hacer muchos segmentos y unirlos todos para hacer el muñequito, pero es demasiado tedioso y no se va a sacar nada nuevo para aprender con este apartado
