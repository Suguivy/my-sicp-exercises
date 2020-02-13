;; P1                        |  mutex  | P2
;; ===============================================================
;; enters test-and-set!      |  false  | enters test-and-set!
;; test `if' cond. (is true) |         | test `if' cond. (is true)
;; sets the mutex to `true'  |  true   |
;;                           |  true   | sets the mutex to `true'
;; returns false             |         | returns false
;;                           |         |
;; the procedure is executed |         | the procedure is executed
