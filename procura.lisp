;;;; Procura.lisp
;;;; Implementacao dos algorimos de procura (BFS, DFS, A*, - bonus - SMA*, IDA*, RBFS)
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318

;(load "projeto.lisp")

;;; Abstract Data Types

;; make-node
; constructs a node with the state (board), depth and the parent node
; returns a list with all data
(defun make-node(state &optional (depth 0) (parent nil))
  (list state depth parent)
)

;; node-state
;  returns a node's state
(defun node-state(node)
  (first node)
)

;; node-depth
;  returns a node's depth
(defun node-depth(node)
  (second node)
)

;; node-parent 
;  returns a parent node of other node 
(defun node-parent(node)
  (third node)
)

;; get-child
;  applies a operation to a node 
;  return a node
(defun get-child(node operation &aux (state (node-state node)))
    "Operation must be a function"
	(cond 
         ((null (funcall operation state)) nil)
         (t (list (funcall operation state) (1+ (depth node)) node)) 
	)
)

;; get-children
;  uses the function get-child and executes multiple operations to a node 
;  return a list of nodes
(defun get-children(node operations-list alg &optional d)
	(cond
         ((null operations-list) nil)
         ((and (equal alg 'dfs) (< d (1+ (depth node)))) nil)
         (t (cons (get-child node (car operations-list)) (get-children node (cdr operations-list) alg d)))
	)
)

;; exist-nodep
;  checks if the node-list contains a node with the same state as the parameter node
;  returns t if exists and nil if it doesn't 
(defun exist-nodep(node node-list)
  (cond 
   ((null node-list)nil)
   (t (eval (cons 'or (mapcar (lambda (x) (cond ((equal (node-state node) (node-state x)) t) (t nil))) node-list))))
   )
)

;; row-count-cells-pieces
;  Count the pieces cells in the list
;  returns number of pieces cells in the list
(defun row-count-cells-pieces(board)
  (cond
    ((null board) 0)
    ((= (first board) 1) (1+ (row-count-cells-pieces (cdr board))))
    (t (row-count-cells-pieces (cdr board)))
    )
)

;; cells-pieces-by-row
;  Receive a list with sublists and count the pieces cells by list
;  return a list with number of pieces cells by list
(defun cells-pieces-by-row (board)
  (cond 
    ((null board) nil)
    (t (cons (row-count-cells-pieces (car board)) (cells-pieces-by-row (cdr board))))
  )
)

;; solutionp 
;  solution state = at least x elems inserted
;  returns a solution node
(defun taken-elems (board)    
    (cond  
      ((null board) 0 )
      (t (+ (first (cells-pieces-by-row (board-a))) (taken-elems (rest board))))
    )   
)

(defun get-solution (node-list solution)
  (cond 
    ((null node-list) nil)
    ((>= (taken-elems (node-state (car node-list))) solution) (car node-list))
    (t (get-solution (cdr node-list) solution))
  )
)

;;;  Algoritmo de procura de Largura Primeiro (BFS)

;; remove-duplicated
;  checks if a list(children) and two other lists(open and close) contain nodes with the same state and remove them 
;  returns a list with non duplicated nodes
(defun remove-duplicated(children open  &optional closed) 
        (cond
            ((or(null children) (null open) (null closed)) nil)
            ((exist-nodep (car children) open) (remove-duplicated (cdr children) open closed))
            ((exist-nodep (car children) closed) (remove-duplicated (cdr children) open closed))
            (t (cons (car children) (remove-duplicated (cdr children) open closed)))
        )
)

;; bfs
;  returns a found node solution
; (bfs get-solution get-children (operations) (make-node (empty-board))) 
(defun bfs(solution get-children operations open &optional (closed nil))
    (cond 
        ((null open) nil) 
        (t (let* ((current-node (car open)) (children (remove-duplicated (funcall 'get-children current-node operations 'bfs) open closed))) 
                (cond 
                    ((null (get-solution children solution)) (bfs solution get-children operations (append (cdr open) children) (cons current-node closed) ))
                    (t (get-solution children solution))
                )
            )
        )  
    )
)


;;;  Algoritmo de Procura do Profundidade Primeiro (DFS)


;;;  Algoritmo de Procura do Melhor Primeiro (A*)


;;;  Os algoritmos SMA*, IDA* e/ou RBFS (bonus)


