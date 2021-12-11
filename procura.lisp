;;;; Procura.lisp
;;;; Implementacao dos algorimos de procura (BFS, DFS, A*, - bonus - SMA*, IDA*, RBFS)
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318


;;; Abstract Data Types

;; make-node
; constructs a node with the state (board), depth and the parent node
; returns a list with all data
(defun make-node(state &optional (depth 0) (parent nil))
  (list state depth parent)
)

(defun node-state(node)
  (first node)
)

(defun node-depth(node)
  (second node)
)


(defun node-parent(node)
  (third node)
)

(defun new-child(node operation &aux (state (node-state node)))
	(cond 
		((null (funcall operation state)) nil)
		(t (list (funcall operation state) (1+ (depth node)) node)) 
	)
)

(defun all-children(node operations-list alg &optional d)
	(cond
		((null operations-list) nil)
		((and (equal alg 'dfs) (< d (1+ (depth node)))) nil)
		(t (cons (new-child node (car operations-list)) (all-children node (cdr operations-list) alg d)))
	)
)


(defun exist-nodep(node node-list)
  (cond 
   ((null node-list)nil)
   (t (eval (cons 'or (mapcar (lambda (x) (cond ((equal (node-state node) (node-state x)) t) (t nil))) node-list))))
   )
)

;;;  Algoritmo de procura de Largura Primeiro (BFS)



;;;  Algoritmo de Procura do Profundidade Primeiro (DFS)


;;;  Algoritmo de Procura do Melhor Primeiro (A*)


;;;  Os algoritmos SMA*, IDA* e/ou RBFS (bonus)


