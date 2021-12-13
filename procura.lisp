;;;; Procura.lisp
;;;; Implementacao dos algorimos de procura (BFS, DFS, A*, - bonus - SMA*, IDA*, RBFS)
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318

;(load "projeto.lisp")

;;; Abstract Data Types

;; make-node
;  constructs a node with the state (board), depth and the parent node
;  returns a list with all data
;  test => (make-node (empty-board))
(defun make-node(state &optional (parent nil) (g 0) (h 0) (pieces '(10 10 15)))
  (list state parent g h pieces)
)

;; node-state
;  returns a node's state
;  test => (node-state (make-node (empty-board)))
(defun node-state(node)
  (first node)
)

;; node-parent 
;  returns a parent node of other node 
;  test => (node-parent (make-node (empty-board) (board-d)))
(defun node-parent(node)
  (second node)
)

;; node-depth
;  returns a node's depth
;  test => (node-depth (make-node (empty-board) (board-d) 1))
(defun node-depth(node)
  (third node)
)

;;  node-h 
;  return heuristic value
;  test => (node-h (make-node (empty-board) (board-d) 1 2))
(defun node-h(node)
  (fourth node) 
)

;; node-pieces-left
;  return list with the number of pieces left by type 
;  test => (node-pieces-left (make-node (empty-board) (board-d) 1 2 '(1 2 3)))  
(defun node-pieces-left(node)
  (nth (1- (length node)) node)
)

;; get-child
;  applies a operation to a node 
;  return a node
;  test => (get-child (make-node (empty-board)) (car (possible-moves (init-pieces) 'piece-a (empty-board))) 'piece-a)
(defun get-child(node possible-move operation &aux (pieces-left (node-pieces-left node)) (state (node-state node)))
    "Operation must be a function"
    (cond 
      ((null (funcall operation pieces-left possible-move state)) nil)
      (t (make-node (funcall operation pieces-left possible-move state) node (1+ (node-depth node)) (node-h node) (remove-used-piece (node-pieces-left node) operation))) 
      )
)

;; get-children 
;  
;  return a list of nodes
(defun get-children(node possible-moves operation)
  (cond 
    ((null possible-moves) nil)
    (t (cons (get-child node (car possible-moves) operation) (get-children node (cdr possible-moves) operation)))
  )
)

;; get-children
;  uses the function get-child and executes multiple operations to a node 
;  return a list of nodes
(defun expand-node(node possible-moves operations alg &optional g)
	(cond
    ((null operations) nil)
    ((and (equal alg 'dfs) (< g (1+ (depth node)))) nil)
    (t (cons (remove-nil(get-children node possible-moves (car operations))) (expand-node node (cdr operations) alg g)))
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
(defun count-row-elems (row &optional (val 1))
  (cond
    ((null row) nil)
    ((= (first row) val) (1+ (count-row-elems (cdr row))))
    (t (count-row-elems (cdr row)))
    )
)

;; cells-pieces-by-row
;  Receive a list with sublists and count the pieces cells by list
;  return a list with number of pieces cells by list
; 
(defun count-board-elems (board &optional (val 1))
  (cond 
    ((null board) nil)
    (t (cons (count-row-elems (car board) val) (count-board-elems (cdr board) val)))
  )
)

;; solutionp 
;  solution state = at least x elems inserted
;  returns a solution 
(defun count-all-elems (board &optional (val 1))    
    (cond  
      ((null board) nil)
      ;(t (+ (first (cells-pieces-by-row (board-a))) (taken-elems (rest board))))
      (t (apply '+ (count-board-elems board val)))
    )   
)


(defun get-solution (node-list solution)
  (cond 
    ((null node-list) nil)
    ((>= (count-all-elems (node-state (car node-list))) solution) (car node-list))
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


