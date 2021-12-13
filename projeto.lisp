;;;; Projeto.lip 
;;;; Carrega os outros ficheiros de codigo, escreve e le ficheiros e trata, ainda, da interacao com o utilizador
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318


;;; Menu

;; init-menu 
;  shows the game's initial menu
(defun init-menu()
  (progn
    (format t "~%_________________________________________________________")
    (format t "~%\\                      BLOKUS UNO                       /")
    (format t "~%/                                                       \\")
    (format t "~%\\     1 - Resolver um tabuleiro                         /")
    (format t "~%/     2 - Mostrar um tabuleiro                          \\")
    (format t "~%\\     3 - Sair                                          /")
    (format t "~%/_______________________________________________________\\~%~%>")
  )
)

(defun choose-algorithm()
  (progn
    (format t "~%_________________________________________________________")
    (format t "~%\\                      BLOKUS UNO                       /")
    (format t "~%/                  Escolha o algoritmo                  \\")
    (format t "~%\\                                                       /")
    (format t "~%/     1 - Breadth-First Search                          \\")
    (format t "~%\\     2 - Depth-First Search                            /")
    (format t "~%/     3 - A*                                            \\")
    (format t "~%\\     4 - IDA*                                          /")
    (format t "~%/     0 - Voltar                                        \\")
    (format t "~%\\                                                       /")
    (format t "~%/_______________________________________________________\\~%~%> ")
  )
)

(defun choose-heuristic()
  (format t "~%_________________________________________________________")
  (format t "~%\\                      BLOKUS UNO                       /")
  (format t "~%/                 Escolha uma heurística                \\")
  (format t "~%\\                                                       /")
  (format t "~%/     1 - Heurística Base                               \\")
  (format t "~%\\     2 - Heurística Desenvolvida                       /")
  (format t "~%/     0 - Voltar                                        \\")
  (format t "~%\\                                                       /")
  (format t "~%/_______________________________________________________\\~%~%> ")
)

(defun choose-depth()
  (format t "~%__________________________________________________________")
  (format t "~%\\                      BLOKUS UNO                        /")
  (format t "~%/           Insira a profundidade máxima desejada        \\")
  (format t "~%\\                     -1 - Voltar                        /")
  (format t "~%/________________________________________________________\\~%~%> ")
)

;;; Files Handler

;; get-problems-path
;  returns the path to the problems.dat file
;(defun get-problems-path ())

;; get-solutions-path
;  returns the path to the file
;(defun get-problems-path ())



;;; User Handler
;; start
;  Receive data from the keyboard, by the user in relation to the option he want to choose
(defun start()
  (progn
    (init-menu)
    (let ((option (read)))
      (if (or (not (numberp option)) (< option 1) (> option 3))
          (progn (format t "Opção inválida") (start))
        (case option
          ('1 (format t "Opção 1"))
          ('2 (format t "Opção 2"))
          ('3 (format t "Adeus!"))
          )
        )
      )
    )
)

;; read-depth-chosen
;  read the depth chosen by the user
(defun read-depth-chosen ()
  (if (not (choose-depth))
      (let ((option (read)))
         (cond ((eq option '-1) );(exec-search))
               ((or (not (numberp option)) (< option -1)) 
                (progn (format t "Opção inválida")) (read-depth-chosen))
               (t option))))
)

;; read-heuristic-chosen
;  read the heuristic chosen by the user
(defun read-heuritic-chosen ()
  (if (not (choose-heuristic))
      (let ((option (read)))
         (cond ((eq option '0) );(exec-search))
               ((or (not (numberp option)) (< option 0)) 
                (progn (format t "Opção inválida")) (read-heuritic-chosen))
               ;((eq option 1) 'base-heuristic)
               ;(T 'best-heuristic)
     )))
)
)
;;;Stats

;; write-bfs-dfs-stats
;  write the solution and measures for the bfs and dfs algorithms
#|
(defun write-bfs-dfs-stats (search)
  (progn
    ;(format "~% *** Solução do Tabuleiro: ***")
    (format "")
    (format "~%~t> Algoritmo:")
    (format "~%~t> Início:")
    (format "~%~t> Fim:")
    (format "~%~t> Tempo Total:")
    (format "~%~t> Fator de ramificação média:")
    (format "~%~t> Número de nós gerados:")
    (format "~%~t> Número de nós expandidos:")
    (format "~%~t> Penetrância:")
    (if (eq search 'dfs)
        (format "~%~t> Profundidade máxima:"))
    (format "~%~t> Comprimento da solução:")
    (format "~%~t> Estado Inicial:")
    ;função para mostrar o estado inical do tabuleiro
    (format "~%~t> Estado Final:")
    ;função para a solução do tabuleiro
   )
)
|#


;; write-a*-stats
;  write the solution and measures for the a* algorithm
#|
(defun write-a*-stats (search)
  (progn
    ;(format "~% *** Solução do Tabuleiro: ***")
    (format "")
    (format "~%~t> Algoritmo:")
    (format "~%~t> Início:")
    (format "~%~t> Fim:")
    (format "~%~t> Tempo Total:")
    (format "~%~t> Fator de ramificação média:")
    (format "~%~t> Número de nós gerados:")
    (format "~%~t> Número de nós expandidos:")
    (format "~%~t> Penetrância:")
    (format "~%~t> Comprimento da solução:")
    (format "~%~t> Estado Inicial:")
    ;função para mostrar o estado inical do tabuleiro
    (format "~%~t> Estado Final:")
    ;função para a solução do tabuleiro
   )
)
|#
;; current-time
;  returns a list with a actual time (hours minutes seconds)
(defun current-time()
  (multiple-value-bind (seconds minutes hours) (get-decoded-time)
    (list hours minutes seconds)
   )
)