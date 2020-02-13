(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else
            (error "Unknown request: MAKE-ACCOUNT"
                   m))))
  dispatch)

#|
+---------------------+
|make-account:*--------->(.)(.)->code...
|acc:*                |   |
|    |                |<--+
|    |                |
+----|----------------+
     |
     |
     |      +----------+<------+
   (.)(.)-->|balance:30|       |
    |       |withdraw:*--->(.)(.)
    |       |deposit:*---->(.)(.)--+
    v       |dispatch:*--->(.)(.)-+|
   code...  +----------+          ||
                    ^ ^           ||
                    | +-----------+|
                    +--------------+

In acc2, a new enviroment is created to store its methods and its balance. The code of the methods (not the environment pointer) is shared.
|#
