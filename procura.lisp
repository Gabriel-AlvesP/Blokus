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
(defun get-child(node possible-move operation &optional (h 'h0) (solution 0) &aux (pieces-left (node-pieces-left node)) (state (node-state node)))
    "Operation must be a function"
    (let ((move (funcall operation pieces-left possible-move state)))
      (cond 
        ((null move) nil)
        (t (make-node move node (1+ (node-depth node)) (hts solution move h) (remove-used-piece (node-pieces-left node) operation))) 
      )
    )
)

;; get-children 
;; Uses the get-child function to create a child for every possible move with a piece
;; Generates all children from a operation(piece)
;; returns a list of nodes 
;; test => (get-children (make-node (board-d)) (possible-moves (init-pieces) 'piece-a (board-d)) 'piece-a)
(defun get-children(node possible-moves operation &optional (h 'h0) (solution 0))
  (cond 
    ((null possible-moves) nil)
    (t (cons (get-child node (car possible-moves) operation h solution) (get-children node (cdr possible-moves) operation h solution)))
  )
)


;; expand-node
;; Uses the get-children function to generate all possibilities from each operation(piece)
;; In sum, expand a node 
;; return a list of nodes
;; test => (expand-node (make-node (empty-board)) 'possible-moves (operations) 'bfs) 
(defun expand-node(node possible-moves operations alg &optional (g 0) (h 'h0) (solution 0))
  "
  [possible-moves] must be a function that returns a list with indexes and the operations,
  [operations] must be a list with all available operations
  "
  (cond
    ((null operations) nil)
    ((and (equal alg 'dfs) (< g (1+ (node-depth node)))) nil)
    (t (remove-nil (append (get-children node (funcall possible-moves (node-pieces-left node) (car operations) (node-state node)) (car operations) h solution)        
                      (expand-node node possible-moves (cdr operations) alg g h solution)
                   )
       )
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
;; returns a possible solution to a problem (node) 
(defun get-solution (node-list solution &optional (val 1))
  "solution must be a number"
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
;; test => (remove-duplicated (list (make-node (board-c)) (make-node (board-d))  (make-node (board-e))) 'duplicatedp (list (make-node (board-b)) (make-node (board-a)) (make-node (empty-board)))  (list (make-node (board-c))))
;; result => (list  node w/ board-d, node w/ board-e
(defun remove-duplicated(node-list duplicated-fun &optional (open nil) closed ) 
        (cond
         ((null node-list) nil)
         ((funcall duplicated-fun (car node-list) open closed) (remove-duplicated (cdr node-list) duplicated-fun open closed))
         (t (cons (car node-list) (remove-duplicated (cdr node-list) duplicated-fun open closed)))
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


;; bfs
;; (bfs 8 (operations) (list (make-node (board-a))))
(defun bfs (solution operations open  &optional (closed nil) (nodes-number 0) (expanded-nodes 0))
  "solution must be a number,
   operations must be a list(must use operations function)"

  (cond 
    ((null open) nil)
    (t (let* ( 
              (current-node (car open))
              (closed1 (cons current-node closed))
              (all-children (expand-node current-node 'possible-moves operations 'bfs))
              (nodes-counter (+ (length all-children) nodes-number))
              (filtered-children (remove-duplicated all-children 'duplicatedp open closed1))
              (open1 (append (cdr open) filtered-children))
              (first-solution (get-solution filtered-children solution))
             )
         (cond 
          ((null first-solution) (bfs solution operations open1 closed1 nodes-counter (1+ expanded-nodes)))
          (t (list first-solution nodes-counter (1+ expanded-nodes)))
         )
      )
    )
  )
)

;;;  Algoritmo de Procura do Profundidade Primeiro (DFS)

;; get-duplicated
;; checks if a node is duplicated
;; returns a node duplicated in node-list
;; test => (duplicated-dfs (make-node (board-b)) (list (make-node (empty-board))) (list (make-node (board-b) nil 1 1 (init-pieces))))
;; result => (car node-list)
(defun get-duplicated (node node-list)
  (cond 
    ((null node-list) nil)
    ;(t (car (remove-nil (mapcar (lambda (x) (cond ((equal (node-state node) (node-state x)) x) (t nil))) closed))))
    ((equal (node-state node) (node-state (car node-list))) (car node-list))
    (t (get-duplicated node (cdr node-list)))
    )
)

;; duplicated-dfs
;; Checks if a node is duplicated in two list(open and closed)
;; returns 
;; nil if open is open 
;; 0 if node is not duplicated and should be added to open
;; 1 if it should abandon the generated node 
;; 2 if it should remove the closed node that is duplicated and add to open
;; test => (duplicated-dfs (make-node (board-b)) (list (make-node (empty-board))) (list (make-node (board-b) nil 1 1 (init-pieces))))
;; result => (car closed)
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

;; remove-closed-duplicated
;; removes the duplicated nodes that cost more than the new generated nodes
;; returns a list with all closed nodes 
(defun remove-closed-duplicated (node-list open closed)
  (let ((duplicated-val (duplicated-dfs (car node-list) open closed)))
    (cond 
      ((null node-list) closed)
      ((numberp duplicated-val) (remove-closed-duplicated (cdr node-list) open closed))
      (t (remove-closed-duplicated (cdr node-list) open (remove duplicated-val closed)))
    )
  )
)


;; dfs
;; (dfs 8 (operations) (list (make-node (board-a))) 2)
(defun dfs (solution operations open max-g  &optional (closed nil) (nodes-number 0) (expanded-nodes 0))
  (cond 
    ((null open) nil)
    (t (let* ( 
              (current-node (car open))
              (all-children (expand-node current-node 'possible-moves operations 'dfs max-g))
              (nodes-counter (+(length all-children) nodes-number))
              (filtered-children (remove-duplicated-dfs all-children (cdr open) (cons current-node closed)))
              (closed1 (remove-closed-duplicated filtered-children (cdr open) (cons current-node closed)))
              (open1 (append filtered-children (cdr open)))
              (first-solution (get-solution filtered-children solution))
            )
        (cond 
          ((null first-solution) (dfs solution operations open1 max-g closed1 nodes-counter (1+ expanded-nodes)))
          (t (list first-solution nodes-counter (1+ expanded-nodes)))
        )
      )
    )
  )
)

;;;  Algoritmo de Procura do Melhor Primeiro (A*)

;; hts
;; selects the heuristic choosed
(defun hts (solution state h-type)
  (cond 
      ((equal h-type 'h0) 0)
      ((equal h-type 'h2) 0)
      (t (h1 solution state))
  )
)

;; h1
;; h(x) = o(x) - c(x)
;; o - board's objective (solution) 
;; c - how many elements/cells are filled (count-all-elems)
(defun h1 (solution state)
  (- solution (count-all-elems state))
)


;; h2
;; ASAP 
(defun h2 ())

;; node-f 
;; calculates a node cost
;; returns a number(cost)
(defun node-f (node)
  (+ (node-depth node) (node-h node))
)


;; duplicatedp-a*
;; Checks if a node is duplicated in a list(closed)
;; Returns t if it is duplicated and nil if it is not
;; test => (duplicatedp-a* (make-node (board-b)) (list (make-node (board-b)) (make-node (board-a)) (make-node (empty-board)))  (list (make-node (board-c))))
;; result => nil
(defun duplicatedp-a*(node &optional open closed)
  (cond 
    ((exist-nodep node closed) t)
    (t nil)
  )
)

;; to-insert-in-open
;; inserir expandidos nao repetidos ou com f < que f do no repetido em abertos, em abertos
;; returns the list of nodes that should be insert in open
(defun to-insert-in-open (expanded-nodes open)
  (let* (
        (current (car expanded-nodes))
        (duplicated-open (get-duplicated current open))
       )
    (cond 
      ((null expanded-nodes) nil)
      ((null duplicated-open) (cons current (to-insert-in-open (cdr expanded-nodes) open)))                
      ((<= (node-f current) (node-f duplicated-open))  (cons current (to-insert-in-open (cdr expanded-nodes) open)))
      (t (to-insert-in-open (cdr expanded-nodes) open))
    )
  )
)

;; get-lowest-node
;; returns the node with a lowest cost in open
(defun get-lowest-node (lowest-node open)
  "[open] list of nodes"
  (let ((open-first (car open)))
    (cond 
      ((null open) lowest-node)
      ((< (node-f lowest-node) (node-f open-first)) (get-lowest-node lowest-node (cdr open)))
      ((and (= (node-f lowest-node) (node-f open-first)) (>= (node-depth lowest-node) (node-depth open-first)))  (get-lowest-node lowest-node (cdr open)))
      (t (get-lowest-node (car open) (cdr open)))
    )  
  )
)


;; check-duplicated
;; checks if there are some duplicated nodes in open that should be removed
;; returns the open list without duplicated nodes
(defun check-duplicated (expanded-nodes open)
  "[open] list with nodes"
  (let* (
        (current (car expanded-nodes))
        (duplicated-open (get-duplicated current open))
       )
    (cond
      ((null expanded-nodes) open)
      ((null duplicated-open) (check-duplicated (cdr expanded-nodes) open))  
      (t (check-duplicated (cdr expanded-nodes) (remove duplicated-open open)))                         
    )
  )
)  

;; a* algorithm
;; test => (a* 72 (operations) (list (make-node (empty-board))) 'h1)
(defun a* (solution operations open heuristic &optional (closed nil) (nodes-number 0) (expanded-nodes 0))
  "
  [solution] must be a number, 
  [operations] must be a list with all operations available
  [open] must be an list with nodes
  "
  (cond
    ((null open) nil)
    (t (let* (
               (current-node (get-lowest-node (car open) open))
               (closed1 (cons current-node closed))
               (all-children (expand-node current-node 'possible-moves operations 'a 0 heuristic solution))
               (nodes-counter (+ (length all-children) nodes-number))
               (filtered-children (to-insert-in-open (remove-duplicated all-children 'duplicatedp-a* open closed1) (cdr open)))
               (open1 (append (check-duplicated filtered-children (cdr open)) filtered-children))
               (sol (get-solution (list current-node) solution))
             )
          (cond 
            ((null sol) (a* solution operations open1 heuristic closed1 nodes-counter (1+ expanded-nodes)))
            (t (list sol nodes-counter (1+ expanded-nodes)))
          )
        )
    )
  )
)

;;; Performance Stats

;; solution-node
;; returns a node that is a solution for the problem 
(defun solution-node(solution-list)
  (first solution-list)
)

;; solution-path
;; returns all nodes that are included in the solution founded
(defun solution-path(solution-list)
  (let ((final-node (solution-node solution-list)))
      (cond 
        ((null (node-parent final-node)) nil)
        (t (cons final-node (solution-path (node-parent final-node))))
    )
  )
)

;; number-of-expanded-nodes 
;; returns a number (expanded nodes)
(defun number-of-expanded-nodes (solution-list)
  "[solution-list] list with all execution info"
  (third solution-list)
)

;; generated-nodes 
;; returns a number (generated nodes)
(defun generated-nodes(solution-list)
  "[solution-list] list with all execution info"
  (second solution-list)
)

;; piercing-factor 
;; represents path length per generated nodes 
;; returns a number (piercing factor aka penetrance)
(defun piercing-factor(solution-list)
  "[solution-list] list with all execution info"
  (/ (+ (node-depth (solution-node solution-list)) 1) (generated-nodes solution-list))
)

;; branching factor
;; returns a number that represents the branching factor average for the
(defun average-branching-factor (solution-list maximum tolerance &optional (minimum 0))
  "
  [solution-list] list with all execution info,
  [maximum] value must be the result of \"generated-nodes\",
  [tolerance] must be a number
  "
  (let* (
          (n-nodes (generated-nodes solution-list))
          (g (node-depth (solution-node solution-list)))
          (average-min-max (/ (+ maximum minimum) 2))                       ; media como fator de ramificacao 
          (average-generated-n (average-generated-nodes average-min-max g))
          (diff (- n-nodes average-generated-n))
        )
      (cond
        ((< diff tolerance) average-min-max)
        ((< average-generated-n n-nodes) (average-branching-factor solution-list maximum average-generated-n)) 
        (t (average-branching-factor solution-list average-generated-n minimum)) 
      )
  )
)

;; average-generated-nodes
;; aux function to [branching-factor]
;; returns the generator nodes 
(defun average-generated-nodes (average g) 
  (cond 
    ((= 1 g) 0)
    (t (+ (expt average g) (average-generated-nodes average (1- g))))
  )
)
