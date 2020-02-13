;; a
(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2))) ; número de elts. del subárbol izq.
	(let ((left-result
	       (partial-tree elts left-size)))
	  (let ((left-tree (car left-result)) ; subárbol izquierdo
		(non-left-elts (cdr left-result)) ; elts. que no están en el subárbol izq.
		(right-size (- n (+ left-size 1)))) ; número de elts. del subárbol dcho.
	    (let ((this-entry (car non-left-elts)) ; raíz del árbol
		  (right-result
		   (partial-tree
		    (cdr non-left-elts)
		    right-size)))
	      (let ((right-tree (car right-result)) ; subárbol derecho
		    (remaining-elts ; elementos no usados de la lista
		     (cdr right-result)))
		(cons (make-tree this-entry
				 left-tree
				 right-tree)
		      remaining-elts))))))))
#|
partial-tree has two parameters, a list of elements and a number n. The procedure
will produce a pair with a tree containing the first n elements of the list and the
remaining elements of the list. If n is equal to zero, the procedure returns an
empty tree and all the elements. If not, the (n-1)/2 elements are used to create
recursively the left subtree, along with its remaining elements. The car of those
remaining elements is the root of the tree, and the cdr are the elements of the right
subtree, that is also computed along with the remaining elements, that are the remaining
elements of the entire tree. Finally, the procedure simply cons a tree with the
root, the left subtree and the right subtree previously calculated and the remaining
elements of the entire tree.

      5
     / \
    /   \
   1     9
    \   / \
     3 7  11
|#

;; b
;; O(n)
