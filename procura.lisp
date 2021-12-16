;;;; Procura.lisp
;;;; Implementacao dos algorimos de procura (BFS, DFS, A*, - bonus - SMA*, IDA*, RBFS)
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318


;;; Abstract Data Types

;; make-node
;;  constructs a node with the state (board), depth and the parent node
;; returns a list with all data
;;  test => (make-node (empty-board))
(defun make-node(state &optional (parent nil) (g 0) (h 0) (pieces '(10 10 15)))
  (list state parent g h pieces)
)

;; node-state
;; returns a node's state
;; test => (node-state (make-node (empty-board)))
(defun node-state(node)
  (first node)
)

;; node-parent 
;; returns a parent node of other node 
;; test => (node-parent (make-node (empty-board) (board-d)))
(defun node-parent(node)
  (second node)
)

;; node-depth
;; returns a node's depth
;; test => (node-depth (make-node (empty-board) (board-d) 1))
(defun node-depth(node)
  (third node)
)

;; node-h 
;; returns heuristic value
;; test => (node-h (make-node (empty-board) (board-d) 1 2))
(defun node-h(node)
  (fourth node) 
)

;; node-pieces-left
;; returns list with the number of pieces left by type 
;; test => (node-pieces-left (make-node (empty-board) (board-d) 1 2 '(1 2 3)))  
(defun node-pieces-left(node)
  (nth (1- (length node)) node)
)

;;; Aux Functions


;; get-child
;; Uses one piece and applies an operation with a possible move to create a child from a node 
;; returns a node
;; test => (get-child (make-node (empty-board)) (car (possible-moves (init-pieces) 'piece-a (empty-board))) 'piece-a)
(defun get-child(node possible-move operation &aux (pieces-left (node-pieces-left node)) (state (node-state node)))
    "Operation must be a function"
    (let ((move (funcall operation pieces-left possible-move state)))
      (cond 
        ((null move) nil)
        (t (make-node move node (1+ (node-depth node)) (node-h node) (remove-used-piece (node-pieces-left node) operation))) 
      )
    )
)

;; get-children 
;; Uses the get-child function to create a child for every possible move with a piece
;; Generates all children from a operation(piece)
;; returns a list of nodes 
;; test => (get-children (make-node (board-d)) (possible-moves (init-pieces) 'piece-a (board-d)) 'piece-a)
(defun get-children(node possible-moves operation)
  (cond 
    ((null possible-moves) nil)
    (t (cons (get-child node (car possible-moves) operation) (get-children node (cdr possible-moves) operation)))
  )
)


;; expand-node
;; Uses the get-children function to generate all possibilities from each operation(piece)
;; In sum, expand a node 
;; return a list of nodes
;; test => (expand-node (make-node (empty-board)) 'possible-moves (operations) 'bfs) 
(defun expand-node(node possible-moves operations alg &optional (g 0))
  "possible moves must be a function that returns a list with indexes and the operations "
  (cond
    ((null operations) nil)
    ((and (equal alg 'dfs) (< g (1+ (node-depth node)))) nil)
    (t (remove-nil (cons (car (get-children node (funcall possible-moves (node-pieces-left node) (car operations) (node-state node)) (car operations)))         
        (expand-node node possible-moves (cdr operations) alg g)
       ))
    )
  )
)

;; exist-nodep
;; checks if the node-list contains a node with the same state as the parameter node
;; returns t if exists and nil if it doesn't 
;; test => (exist-nodep (make-node (empty-board)) (list (make-node (board-d))(make-node (empty-board))))
(defun exist-nodep(node node-list)
  (cond 
   ((null node-list)nil)
   (t (eval (cons 'or (mapcar (lambda (x) (cond ((equal (node-state node) (node-state x)) t) (t nil))) node-list))))
   )
)

;; count-row-elems
;; Count the elements/cells in the list with a the val
;; returns number of elements/cells in the list with the val
;; test => (count-row-elems (list 1 0 0 1 1 1) 0)
;  result => 2
(defun count-row-elems (row &optional (val 1))
  (cond
    ((null row) 0)
    ((= (car row) val) (1+ (count-row-elems (cdr row) val)))
    (t (count-row-elems (cdr row) val))
    )
)

;; cells-pieces-by-row
;;  Receive a list(board) with sublists(rows) and count the elements with the val(value)
;;  returns a list with each result of count-row-elems(row);
;;  test => (count-row-elems (list 1 0 0 1 1 1) 0)
;;  result => (14 14 14 14 14 14 14 14 14 14 14 14 14 14)
(defun count-board-elems (board &optional (val 1))
  (cond 
    ((null board) nil)
    (t (cons (count-row-elems (car board) val) (count-board-elems (cdr board) val)))
  )
)

;; count-all-elems   
;; solution state = at least x elems inserted
;; returns a solution 
;; test => (count-all-elems (empty-board) 0)
;; result => 196
(defun count-all-elems (board &optional (val 1))    
    (cond  
      ((null board) nil)
      (t (apply '+ (count-board-elems board val)))
    )   
)

;; solutionp
;; Verifies if a node is a solution for the problem
;; returns a node if it is a solution and nil if it isn't
;; test => (solutionp (make-node (board-d)) 98 2)
;; result => node
(defun solutionp (node solution &optional (val 1))
  "solution must be and number"
  (cond 
    ((null node) nil)
    ((>= (count-all-elems (node-state node) val) solution) t)
    (t nil)
  )
)


;; get-solution
;; 
;; returns a list with the possible solutions to a problem 
(defun get-solution (node-list solution &optional (val 1))
  (cond 
    ((null node-list) nil)
    ((solutionp (car node-list) solution val) (car node-list))
    ;(t (remove-nil(cons (solutionp (car node-list) solution val) (get-solution (cdr node-list) solution val))))    
    (t (get-solution (cdr node-list) solution val))
  )  
)

;;;  Algoritmo de procura de Largura Primeiro (BFS)

;; remove-duplicated
;;  checks if a list(node) exists in the two other lists(open and close)
;;  remove the duplic 
;;  returns a list with non duplicated nodes
;; test => (remove-duplicated (list (make-node (board-c)) (make-node (board-d)) (make-node (board-e))) (list (make-node (board-b)) (make-node (board-a)) (make-node (empty-board)))  (list (make-node (board-c))))
;; result => (list  node w/ board-d, node w/ board-e
(defun remove-duplicated(node-list open  &optional closed) 
        (cond
         ((null node-list) nil)
         ((duplicatedp (car node-list) open closed) (remove-duplicated (cdr node-list) open closed))
         (t (cons (car node-list) (remove-duplicated (cdr node-list) open closed)))
        )
)

;; duplicatedp
;; Checks if a node is duplicated in two list of nodes(open and closed)
;; Returns t if it is duplicated and nil if it is not 
;; test => (duplicatedp (make-node (board-c)) (list (make-node (board-b)) (make-node (board-a)) (make-node (empty-board)))  (list (make-node (board-c))))
;; result => T
(defun duplicatedp (node open &optional closed)
  (cond 
    ((or (null node) (null open)) nil)
    ((or (exist-nodep node open) (exist-nodep node closed)) t)
    (t nil)
  )
)

;;
;;
;; (bfs 8 (operations) (list (make-node (board-a))))
(defun bfs (solution operations open  &optional (closed nil))
  (cond 
    ((null open) nil)
    (t (let* ( 
              (current-node (car open))
              (closed1 (cons current-node closed))
              (filtered-children (remove-duplicated (expand-node current-node 'possible-moves operations 'bfs) open closed1))
              (open1 (append (cdr open) filtered-children))
              (first-solution (get-solution filtered-children solution))
             )
         (cond 
          ((null first-solution) (bfs solution operations open1 closed1))
          (t first-solution)
         )
       )
    )
  )
)


;;;  Algoritmo de Procura do Profundidade Primeiro (DFS)

;; get-duplicated
;; checks if a node is duplicated
;; returns a node duplicated in closed
;; test => (duplicated-dfs (make-node (board-b)) (list (make-node (empty-board))) (list (make-node (board-b) nil 1 1 (init-pieces))))
;; result => (car closed)
(defun get-duplicated (node closed)
  (cond 
    ((null closed) nil)
    ;(t (car (remove-nil (mapcar (lambda (x) (cond ((equal (node-state node) (node-state x)) x) (t nil))) closed))))
    ((equal (node-state node) (node-state (car closed))) (car closed))
    (t (get-duplicated node (cdr closed)))
    )
)

;;    ((< (node-depth node) (node-depth duplicated-node)) (remove duplicated-node closed))

;; duplicated-dfs
;; Checks if a node is duplicated in two list of nodes(open and closed)
;; returns 
;;  nil if open is open 
;;  0 if node is not duplicated and should be added to open
;;  1 if it should abandon the generated node 
;;  2 if it sho;; test => (duplicated-dfs (make-node (board-b)) (list (make-node (empty-board))) (list (make-node (board-b) nil 1 1 (init-pieces))))uld remove the closed node that is duplicated and add to open
;;  result => (car closed)
(defun duplicated-dfs (node open closed)
    (let ((duplicated-node (get-duplicated node closed)))
    (cond 
      ((exist-nodep node open) 1)
      ((null duplicated-node) 0)
      ((< (node-depth node) (node-depth duplicated-node)) duplicated-node)
      (t 1)
     )
  )
)
 


;; remove-duplicated-dfs
;; checks if a list(node) exists in the two other lists(open and close)
;; remove the 
;; returns a list with non duplicated nodes
;; test => (remove-duplicated-dfs (list (make-node (empty-board)) (make-node (board-c))) (list (make-node (empty-board))) (list (make-node (board-e))))
;; result =>  (list node w/ board-c)
(defun remove-duplicated-dfs(node-list open closed) 
  (let ((duplicated-val (duplicated-dfs (car node-list) open closed)))
    (cond
      ((null node-list) nil) 
      ((= 0 duplicated-val) (cons (car node-list) (remove-duplicated-dfs (cdr node-list) open closed)))
      (t (remove-duplicated-dfs (cdr node-list) open closed))  
    )
  )
)



;; closed-duplicated
;; 
;;
(defun closed-duplicated (node-list open closed)
  (let ((duplicated-val (duplicated-dfs (car node-list) open closed)))
    (cond 
      ((null node-list) closed)
      ((numberp duplicated-val) (closed-duplicated (cdr node-list) open closed))
      (t (closed-duplicated (cdr node-list) open (remove duplicated-val closed)))
    )
  )
)


(defun dfs (solution operations open max-g  &optional (closed nil))
  (cond 
    ((null open) nil)
    (t (let* ( 
              (current-node (car open))
              (filtered-children (remove-duplicated-dfs (expand-node current-node 'possible-moves operations 'dfs max-g) (cdr open) (cons current-node closed)))
              (closed1 (closed-duplicated filtered-children (cdr open) (cons current-node closed)))
              (open1 (append filtered-children (cdr open)))
              (first-solution (get-solution filtered-children solution))
            )
        (cond 
          ((null first-solution) (bfs solution operations open1 closed1))
          (t  first-solution)
        )
      )
    )
  )
)

;;;  Algoritmo de Procura do Melhor Primeiro (A*)

;; h1
;; h(x) = o(x) - c(x)
;; o - objetivo para o tabuleiro 
;; c - numero de quadrados preenchidos no tabuleiro
(defun h1 (solution node)
  (- solution (count-all-elems (node-state node)))
)


;; h2
;; 
;; 
;; 
(defun h2 ())

;; f 
;; 
;;
(defun f (node)
  (+ (node-depth node) (node-h node))
)

#|(defun sort (node-list)
  (let (())

  )
)

(defun a* (solution operations open &optional (closed nil))
  (cond
    ((null open) nil)
    (t (let* ))
  
  )
)


;;; Performance Stats


(defun generated-nodes())

(defun penetrance())

|#
;;;  Os algoritmos SMA*, IDA* e/ou RBFS (bonus)


