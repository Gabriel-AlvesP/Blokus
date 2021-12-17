;;;; Projeto.lip 
;;;; Carrega os outros ficheiros de codigo, escreve e le ficheiros e trata, ainda, da interacao com o utilizador
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318


;;; Menu

;; init-menu 
;;  shows the game's initial menu
(defun init-menu()
  (progn
    (format t "~%_________________________________________________________")
    (format t "~%\\                      BLOKUS UNO                       /")
    (format t "~%/                                                       \\")
    (format t "~%\\     1 - Escolher algoritmo                            /")
    (format t "~%/                                                       \\")  
    (format t "~%\\     0 - Sair                                          /")
    (format t "~%/_______________________________________________________\\~%~%>")
  )
)

;; choose-algorithm
;; shows the algorithms menu
(defun choose-algorithm()
  (progn
    (format t "~%_________________________________________________________")
    (format t "~%\\                      BLOKUS UNO                       /")
    (format t "~%/                  Escolha o algoritmo                  \\")
    (format t "~%\\                                                       /")
    (format t "~%/     1 - Breadth-First Search                          \\")
    (format t "~%\\     2 - Depth-First Search                            /")
    (format t "~%/     3 - A*                                            \\")
    (format t "~%\\     0 - Voltar                                        /")
    (format t "~%/_______________________________________________________\\~%~%> ")
  )
)

;; choose-heuristic
;; show the heuristics menu
(defun choose-heuristic()
  (format t "~%_________________________________________________________")
  (format t "~%\\                      BLOKUS UNO                       /")
  (format t "~%/                 Escolha uma heur�stica                \\")
  (format t "~%\\                                                       /")
  (format t "~%/     1 - Heur�stica Base                               \\")
  (format t "~%\\     2 - Heur�stica Desenvolvida                       /")
  (format t "~%/     0 - Voltar                                        \\")
  (format t "~%\\                                                       /")
  (format t "~%/_______________________________________________________\\~%~%> ")
)

;; choose-depth
;; menu for user enter depth 
(defun choose-depth()
  (format t "~%__________________________________________________________")
  (format t "~%\\                      BLOKUS UNO                        /")
  (format t "~%/           Insira a profundidade m�xima desejada        \\")
  (format t "~%\\                     -1 - Voltar                        /")
  (format t "~%/________________________________________________________\\~%~%> ")
)

;; choose-board 
;; shows the board choice menu
(defun choose-board()
  (format t "~%__________________________________________________________")
  (format t "~%\\                      BLOKUS UNO                        /")
  (format t "~%/                  Escolha um tabulerio                  \\")
  (format t "~%\\                  1 - 1� Tabuleiro                      /")
  (board-solution (load-problems-file) 1)
  (format t "~%\\                  2 - 2� Tabuleiro                      /")
  (board-solution (load-problems-file) 2)
  (format t "~%\\                  3 - 3� Tabuleiro                      /")
  (board-solution (load-problems-file) 3)
  (format t "~%\\                  4 - 4� Tabuleiro                      /")
  (board-solution (load-problems-file) 4)
  (format t "~%\\                  5 - 5� Tabuleiro                      /")
  (board-solution (load-problems-file) 5)
  (format t "~%\\                  6 - 6� Tabuleiro                      /")
  (board-solution (load-problems-file) 6)
  (format t "~%\\                                                        /")
  (format t "~%/________________________________________________________\\~%~%> ")
)


;;; Files Handler

;; get-problems-path
;; returns the path to the problems.dat file 
(defun get-problems-path()
  (make-pathname :host "D" :directory '(:absolute "IPS\\3� Ano\\1� Semestre\\Intelig�ncia Artificial\\Blokus") :name "problemas" :type "dat")   
)

;; get-solutions-path
;; returns the path to the solutions.dat file
(defun get-results-path()
  (make-pathname :host "D" :directory '(:absolute "IPS\\3� Ano\\1� Semestre\\Intelig�ncia Artificial\\Blokus") :name "resultados" :type "dat")
)

;; load-problems-file
;; returns all boards of problemas.dat file
;; teste -> (load-problems-file)
(defun load-problems-file ()
  (with-open-file (stream (get-problems-path))
    (labels ((read-recursively ()
               (let ((line (read stream nil 'eof)))
                 (if (eq line 'eof) nil (cons line (read-recursively))))))
      (read-recursively))
    )
  )

;; get-board-to-use
;; returns the board
;; teste -> (get-board-to-use (load-problems-file) 1)
(defun get-board (file number)
  (cond  
   ((= number 1) (car (nth 1 file)))
   ((= number 2) (car (nth 3 file)))
   ((= number 3) (car (nth 5 file)))
   ((= number 4) (car (nth 7 file)))
   ((= number 5) (car (nth 9 file)))
   ((= number 6) (car (nth 11 file)))
   (t nil))
  )

;; board-solution
;; returns board-solution 
;; teste -> (get-board-solution (load-problems-file) 1)
(defun board-solution (file number)
  (cond
   ((= number 1) (cadr (nth 1 file)))
   ((= number 2) (cadr (nth 3 file)))
   ((= number 3) (cadr (nth 5 file)))
   ((= number 4) (cadr (nth 7 file)))
   ((= number 5) (cadr (nth 9 file)))
   ((= number 6) (cadr (nth 11 file)))
   (t nil))
  ) 


;; write-file
;; <algorithm> list with algorithm, start time, end time, duration time, solution-path, depth, board,fator de ramifica��o m�dia, n� de n�s gerados,n� de n�s expandidos, penetr�ncia, comprimento da solu��o
(defun write-file(algorithm)
  (with-open-file (stream (get-results-path) :direction :output :if-exists :append :if-does-not-exist :create)
    (cond
     (format t "teste")
     ;((condi��o) (o que fazer))
     ;((condi��o) ())
     ;(() ())
     (t nil)
     )
    )
  )


;;; User Handler

;; start
;; Receive data from the keyboard, by the user in relation to the option he want to choose
(defun start()
  (init-menu)
  (let ((option (read)))
    (if (and (numberp option) (>= option 0) (<= option 1)) 
        (cond
         ((equal option 1) (run-algorithm))
         ((equal option 0) (print "Adeus!"))
         ) 
      (progn (print "Op��o inv�lida. Tente novamente") (start))
      )
    )
  )
  
;; run-algorithm
;; run the algorithm chosen by the user
(defun run-algorithm ()
  (choose-algorithm)
  (let ((option (read)))
    (if (and (numberp option) (>= option 0) (<= option 3))
        (cond
         ((equal option 1) 
          (progn  
            (let* ((solution-number (read-board-chosen)))
                   ;(board (get-board solution-number))) 
              (bfs (board-solution (load-problems-file) solution-number) (operations) (list (make-node (get-board (load-problems-file) solution-number)))))))
         ((equal option 2) 
          (progn 
            (let* ((solution-number (read-board-chosen))
                   (depth (read-depth-chosen)))
              (dfs (board-solution (load-problems-file) solution-number) (operations) (list (make-node (get-board (load-problems-file) solution-number))) depth))))
         ((equal option 3) 
          (progn
            (let* ((solution-number (read-board-chosen))
                   (heuristic (read-heuritic-chosen)))
              (a* (board-solution (load-problems-file) solution-number) (operations) (list (make-node (get-board (load-problems-file) solution-number))) heuristic))))
         ((equal option 0) (start))
         )
      (progn (format t"~% Op��o inv�lida.~% Tente novamente.") (run-algorithm))
      )
    )
  )
   

;; read-depth-chosen
;; read the depth chosen by the user
(defun read-depth-chosen ()
  (choose-depth)
  (let ((option (read)))
    (cond
     ((and (numberp option) (equal option -1)) (run-algorithm))
     ((numberp option) option)
     (t (read-depth-chosen));;e manda print op��o invalida
     )
    )
  )


;; read-heuristic-chosen
;; read the heuristic chosen by the user
(defun read-heuritic-chosen ()
  (choose-heuristic)
  (let ((option (read)))
    (if (and (numberp option) (>= option 0) (<= option 2))
        (cond
         ((equal option 1) 'h1)
         ((equal option 2) (print "executa heuristica desenvolvida"))
         ((equal option 0) (run-algorithm))
         )
      (print "op��o inv�lida e chama read-heuritic-chosen")
      )
    )
  )


;; read-board-chosen
;; read the board chosen by the user
(defun read-board-chosen()
  (choose-board)
  (let ((option (read)))
    (if (and (numberp option) (>= option 0) (<= option 6))
        option
      (progn (format t"~% Op��o inv�lida.~% Tente novamente.") (read-board-chosen))
      )
    )
  )


;;;Stats

;; write-bfs-and-dfs-stats
;; write the solution and measures for the bfs and dfs algorithms
;fun��o para o estado inicial e fun��o para o estado final
(defun write-bfs-dfs-stats ()
    (format t "~% *** Solu��o do Tabuleiro: ***")
    (terpri t)
    (format t "~%~tAlgoritmo: ~a" )
    (format t"~%~tIn�cio:")
    (format t"~%~tFim:")
    (format t"~%~tTempo Total:")
    (format t"~%~tFator de ramifica��o m�dia:")
    (format t"~%~tN�mero de n�s gerados:")
    (format t"~%~tN�mero de n�s expandidos:")
    (format t"~%~tPenetr�ncia:")
    ;(if (eq search 'dfs)
    ;    (format t"~%~tProfundidade m�xima:"))
    (format t"~%~tComprimento da solu��o:")
    (format t"~%~tEstado Inicial:")
    ;fun��o para mostrar o estado inical do tabuleiro
    (format t"~%~tEstado Final:")
    ;fun��o para a solu��o do tabuleiro
    (terpri t)
    (format t"~%~t------ Fim de Execu��o ------")
    (terpri t)
    (terpri t)
)



;; write-a*-stats
;; write the solution and measures for the a* algorithm
(defun write-a*-stats (solution-list) 
    (format t "~% *** Solu��o do Tabuleiro: ***")
    (format t "~%~tAlgoritmo:" )
    (format t "~%~tIn�cio: ")
    (format t "~%~tFim: " (current-time))
    (format t "~%~tTempo Total: " (current-time))
    (format t "~%~tFator de ramifica��o m�dia: " (average-branching-factor (solution-list maximum tolerance &optional (minimum 0))))
    (format t "~%~tN�mero de n�s gerados: " (generated-nodes solution-list))
    (format t "~%~tN�mero de n�s expandidos: " (number-of-expanded-nodes solution-list))
    (format t "~%~tPenetr�ncia: " )
    (format t "~%~tComprimento da solu��o:")
    (format t "~%~tEstado Inicial:")
    ;fun��o para mostrar o estado inical do tabuleiro
    (format t "~%~tEstado Final:")
    ;fun��o para a solu��o do tabuleiro
    (terpri t)
    (format t"~%~t------ Fim de Execu��o ------")
    (terpri t)
    (terpri t)
  )


;; current-time
;; returns a list with a actual time (hours minutes seconds)
(defun current-time()
  (multiple-value-bind (seconds minutes hours) (get-decoded-time)
    (format t "~d:~d:~d" hours minutes seconds)
   )
)