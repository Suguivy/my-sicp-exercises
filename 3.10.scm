(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))

(W1 (make-withdraw 100))

#|
+---------------------------+
|make-withdraw:...          |
|W1:*                       |<--+
|   |                       |   |
+---|-----------------------+   |
    |       +-----------+  +-------------------+
  (.)(.)--->|balance:100|->|initial-ammount:100|
   |        +-----------+  +-------------------+
   v
parameters: amount
body: ...
|#

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))))
(W2 (make-withdraw 100))

#|
+---------------------------+
|make-withdraw:...          |
|W2:*                       |
|   |                       |
+---|-----------------------+
    |             ^
    |             |
    |       +-----------+
  (.)(.)--->|balance:100|
   |        +-----------+
   v
parameters: amount
body: ...
|#





