(define tree (generate-huffman-tree '((A 2) (BOOM 1) (GET 2) (JOB 2) (SHA 3) (NA 16) (WAH 1) (YIP 9))))

(define encoded-message (encode '(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom) tree))

(length encoded-message) ; -> 84
;; 84 bits are required for encoding

;; 3 * (2 + 1 + 2 + 2 + 3 + 16 + 1 + 9) = 108 bits are required for encoding
