;; This works becuase with that, a definition for magnitude when the external tag is 'complex' is given.
(magnitude z)
(apply-generic 'magnitude z) ;; Dispatched magnitude procedure from complex package
(apply magnitude (contents z))
(apply magnitude (cons 'rectangular (cons 3 4)))
(magnitude (cons 'rectangular (cons 3 4)))
(apply-generic 'magnitude (cons 'rectangular (cons 3 4))) ;; Dispatched magnitude procedure from rectangular package
(apply magnitude (contents (cons 'rectangular (cons 3 4))))
(apply magnitude (cons 3 4))
(magnitude (cons 3 4))
5
;; apply-generic is invoked 2 times
