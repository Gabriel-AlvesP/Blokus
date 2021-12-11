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

(defun node-state(node)
  (first node)
)

(defun node-depth(node)
  (second node)
)


(defun node-parent(node)
  (third node)
)

(defun get-child(node operation &aux (state (node-state node)))
	(cond 
		((null (funcall operation state)) nil)
		(t (list (funcall operation state) (1+ (depth node)) node)) 
	)
)

(defun get-children(node operations-list alg &optional d)
	(cond
		((null operations-list) nil)
		((and (equal alg 'dfs) (< d (1+ (depth node)))) nil)
		(t (cons (get-child node (car operations-list)) (get-children node (cdr operations-list) alg d)))
	)
)

(defun exist-nodep(node node-list)
  (cond 
   ((null node-list)nil)
   (t (eval (cons 'or (mapcar (lambda (x) (cond ((equal (node-state node) (node-state x)) t) (t nil))) node-list))))
   )
)

;;;  Algoritmo de procura de Largura Primeiro (BFS)

;; 
;  returns a list with all non expanded children
(defun remove-duplicated(children open closed) 
        (cond
            ((or(null children) (null open) (null closed)) nil)
            ((eval (cons 'or (mapcar 'exist-nodep  (car children) open))) (remove-duplicated (cdr children) open closed))
            ((eval (cons 'or (mapcar 'exist-nodep  (car children) closed))) (remove-duplicated (cdr children) open closed))
            (t (cons (car children) (remove-duplicated (cdr children) open closed)))
        )
)

;; bfs
;  returns a found node solution
(defun bfs(solution-fun get-children operations &optional (closed nil) (opened nil)  node-init)
    (cond 
        ((not (null node-init))  (bfs solution-fun get-children operations closed (cons node-init opened)))
        ((null opened) nil)
        (t (let ((current-node (car opened)) (children (remove-duplicated (get-children node-init operations 'bfs) opened closed))) 
                (cond 
                    ((mapcar 'solution-fun (append (cdr opened) children)) current-node)
                    (t (bfs solution-fun get-children operations (cons (car opened) closed) (append (cdr opened) children)))
                )
            )
        )  
    )
)

;;;  Algoritmo de Procura do Profundidade Primeiro (DFS)


;;;  Algoritmo de Procura do Melhor Primeiro (A*)


;;;  Os algoritmos SMA*, IDA* e/ou RBFS (bonus)


