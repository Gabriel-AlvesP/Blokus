;;;; Puzzle.lisp
;;;; Codigo relacionado com o problema
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318



;;; Problems

;; Problem A
;; At least 8 elements fulfilled
(defun board-a()
    ;A B C D E F G H I J K L M N
  '((0 0 0 0 2 2 2 2 2 2 2 2 2 2)
    (0 0 0 0 2 2 2 2 2 2 2 2 2 2)
    (0 0 0 0 2 2 2 2 2 2 2 2 2 2)
    (0 0 0 0 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2))
)

;; Problem b
;; At least 20 elements fulfilled
(defun board-b()
    ;A B C D E F G H I J K L M N
  '((0 0 0 0 0 0 0 2 2 2 2 2 2 2)
    (0 0 0 0 0 0 0 2 2 2 2 2 2 2)
    (0 0 0 0 0 0 0 2 2 2 2 2 2 2)
    (0 0 0 0 0 0 0 2 2 2 2 2 2 2)
    (0 0 0 0 0 0 0 2 2 2 2 2 2 2)
    (0 0 0 0 0 0 0 2 2 2 2 2 2 2)
    (0 0 0 0 0 0 0 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2)
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2))
)

;; Problem c
;; At least 28 elements fulfilled
(defun board-c()
    ;A B C D E F G H I J K L M N
  '((0 0 2 0 0 0 0 0 0 2 2 2 2 2) ;1
    (0 0 0 2 0 0 0 0 0 2 2 2 2 2) ;2
    (0 0 0 0 2 0 0 0 0 2 2 2 2 2) ;3
    (0 0 0 0 0 2 0 0 0 2 2 2 2 2) ;4
    (0 0 0 0 0 0 2 0 0 2 2 2 2 2) ;5
    (0 0 0 0 0 0 0 2 0 2 2 2 2 2) ;6
    (0 0 0 0 0 0 0 0 2 2 2 2 2 2) ;7
    (0 0 0 0 0 0 0 0 0 2 2 2 2 2) ;8
    (0 0 0 0 0 0 0 0 0 2 2 2 2 2) ;9
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;10
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;11
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;12
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;13
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2));14
)

;; Problem d
;; At least 36 elements fulfilled
(defun board-d()
    ;A B C D E F G H I J K L M N
  '((0 0 0 0 0 0 0 0 0 0 0 0 0 0) ;1
    (0 0 0 0 0 0 0 0 0 0 0 0 0 0) ;2
    (0 0 0 0 0 0 0 0 0 0 0 0 0 0) ;3
    (0 0 0 0 0 0 0 0 0 0 0 0 0 0) ;4
    (0 0 0 0 0 0 0 0 0 0 0 0 0 0) ;5
    (0 0 0 0 0 0 0 0 0 0 0 0 0 0) ;6
    (0 0 0 0 0 0 0 0 0 0 0 0 0 0) ;7
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;8
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;9
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;10
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;11
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;12
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2) ;13
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2));14
)

;; Problem e
;; At least 44 elements fulfilled
(defun board-e()
    ;A B C D E F G H I J K L M N
  '((0 2 2 2 2 2 2 2 2 2 2 2 2 2) ;1
    (2 0 2 0 0 0 0 0 0 2 0 0 0 2) ;2
    (2 0 0 2 0 0 0 0 0 0 2 0 0 2) ;3
    (2 0 0 0 2 0 0 0 0 0 0 2 0 2) ;4
    (2 0 0 0 0 2 0 0 0 0 0 0 2 2) ;5
    (2 0 0 0 0 0 2 0 0 0 0 0 0 2) ;6
    (2 0 0 0 0 0 0 2 0 0 0 0 0 2) ;7
    (2 0 0 0 0 0 0 0 2 0 0 0 0 2) ;8
    (2 0 0 0 0 0 0 0 0 2 0 0 0 2) ;9
    (2 0 2 0 0 0 0 0 0 0 2 0 0 2) ;10
    (2 2 0 0 0 0 0 0 0 0 0 2 0 2) ;11
    (2 0 0 0 2 0 0 0 0 0 0 0 2 2) ;12
    (2 0 0 0 0 2 0 0 0 0 0 0 0 2) ;13
    (2 2 2 2 2 2 2 2 2 2 2 2 2 2));14
)

;;; Board

;; Problem f
;; At least 72 elements fulfilled
;; Empty Board 14x14 
;  Returns a 14x14 empty board 
(defun empty-board (&optional (dimension 14))
	(make-list dimension :initial-element (make-list dimension :initial-element '0))
)

;; row
;  returns a particular row based on an index
(defun row(index board)
  "Index must be a number between 0 and the board dimension"
  (nth index board)
)

;; column 
;  returns a particular column based on an index
(defun column(index board)
  "Index must be a number between 0 and the board dimension"
  (mapcar (lambda (x) (nth index x))  board) 
)

;; element
;  returns a particular element based on row (r) and column (col) indexes
(defun element(r col board)
    "r and col must be numbers between 0 and the board dimension"
  (nth col (row r board))
)


;;; Secondary functions

;; empty-elemp
;  returns t if a board element is empty(or the value - val) and nil if it isn't
(defun empty-elemp(row col board &optional (val 0))
  "row and col must be numbers between 0 and the board dimension"
  (cond 
  ((or (< row 0) (> row (1- (length board))) (< col 0) (> col (1-(length board)))) nil)
  ((= (element row col board) val) t)
  (t nil)
  )
)

;; check-empty-elems 
;  checks if each element of indexes-list is empty or not in the board
;  indexes-list - ex -  ((0 0) (0 2) (4 2))
;  returns a list of t and nil depending on each index  
(defun check-empty-elems(board indexes-list &optional (val 0))
  "Each element(list with row and col) in indexes-list
   must contain a valid number for the row and column < (length board)"
  (mapcar (lambda (index) (empty-elemp (first index) (second index) board val)) indexes-list)
)


;; replace-pos 
;  replaces a position in the board for val
;  returns a row(list) with element in column(col) position replaced by the val
(defun replace-pos (col row &optional (val 1))
    "Col (column) must be a number between 0 and the row length"
    (cond 
     ((null row) nil)
     ((= col 0) (cons val (replace-pos (1- col) (cdr row) val)))
     (t (cons (car row) (replace-pos (1- col) (cdr row) val)))
    )
)

;; replace 
;  replaces an element in the board  
;  returns the all board with element replaced by the value
(defun replace- (row col board &optional (val 1))
  "Row and column must be a number between 0 and the board length"
  (cond  
   ((null board) nil)
   ((= row 0) (cons (replace-pos col (car board) val) (replace- (1- row) col (cdr board) val)))
   (t (cons (car board) (replace- (1- row) col (cdr board) val)))
  )
)

;; replace-multi-pos
;  replaces multiple positions in the board
;  pos-list => list with all positions to replace
;  returns the all board with all elements replaced 
(defun replace-multi-pos (pos-list board &optional (val 1))
    (cond 
      ((null pos-list) board)
      (t (replace-multi-pos (cdr pos-list) (replace- (first (car pos-list)) (second (car pos-list)) board val)))
    )
)

;; insert-piece
;  uses the piece-taken-elems to push pieces into the board
(defun insert-piece (row col board piece)
  (cond 
    ((or (> row (length board))  (< row 0) (< col 0) (> col (length board))) nil)
    ((not (check-adjacent-elems row col board piece)) nil)
    ((eval (cons 'and (check-empty-elems board (piece-taken-elems row col piece))))
    (replace-multi-pos (piece-taken-elems row col piece) board))
    (t nil)
   )
)

;; check-adjacent-elems
;  check if adjacente elements/cells are taken (1, 2 or +)
;  if, in fact, they are taken then returns null
;  else 
(defun check-adjacent-elems (row col board piece)
  (cond
   ((eval (cons 'or (check-empty-elems board (piece-adjacent-elems row col piece) 1))) nil)
   (t t)
   )
)

;; piece-adjacent-elems
;  returns a list wirh all adjacent elements/cells that a particular  piece takes in a board
(defun piece-adjacent-elems (row col piece)
  (cond
   ((equal piece 'peca-a) (list (list row (1+ col)) (list row (1- col)) (list (1+ row) col) (list (1- row) col)))
   ((equal piece 'peca-b) (list (list row (1- col)) (list (1+ row) (1- col)) (list (1- row) col) (list (1- row) (1+ col)) (list (+ row 2) col) (list (+ row 2) (1+ col)) (list row (+ col 2)) (list (1+ row) (+ col 2))))
   ((equal piece 'peca-c-1) (list (list (1- row) col) (list row (1- col)) (list (1+ row) col) (list (1+ row) (1+ col)) (list row (+ col 2)) (list (1- row) (+ col 3)) (list (1- row) (+ col 2)) (list (1- row) (1+ col))))
   ((equal piece 'peca-c-2) (list (list (1- row) col) (list row (1- col)) (list row (1+ col)) (list (1+ row) (1- col)) (list (1+ row) (+ col 2)) (list (+ row 2) col) (list (+ row 2) (+ col 2)) (list (+ row 3) (1+ col))))
   (t nil)
   )
)



;; piece-taken-elems 
;  returns a list with all elements/cells that a particular piece takes in a board
(defun piece-taken-elems (row col piece)
  (cond 
   ((equal piece 'peca-a) (cons (list row col) nil))                                            
   ((equal piece 'peca-b)                                  
    (list (list row col) (list row (1+ col)) (list (1+ row) col) (list (1+ row) (1+ col)))         
    )
   ((equal piece 'peca-c-2) 
    (list (list row col) (list (1+ row) col) (list (1+ row) (1+ col)) (list (+ row 2) (1+ col)))  
    ) 
   ((equal piece 'peca-c-1) (list (list row col) (list row (1+ col)) (list (1- row) (1+ col)) (list (1- row) (+ col 2))))
   (t nil)
   )
)

;;; Operators

;; operations
;  returns a list with all operations
(defun operations()
  (list 'piece-a 'piece-b 'piece-c-1 'piece-c-2)
)

;; piece-a
;  returns 
(defun piece-a (row col board)
  (insert-piece row col board 'peca-a)
)

;; piece-b
;
(defun piece-b (row col board)
   (insert-piece row col board 'peca-b)
)

;; piece-c-1
;
(defun piece-c-1 (row col board)
  (insert-piece row col board 'peca-c-1)
)

;; piece-c-2
;
(defun piece-c-2 (row col board)
  (insert-piece row col board 'peca-c-2)
)

;; solutionp 
;  solution state = at least x elems inserted
;  returns a solution node 
(defun solutionp(check-taken-elems node)
)


