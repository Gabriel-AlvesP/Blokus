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
;  shows the board choice menu
(defun choose-board(&optional(i 1) (boards (load-problems-file)))	
  (cond
   ((null boards) 
    (progn   
      (format t "~%/                     0 - Voltar                            /")
      (format t "~%/___________________________________________________________\\~%~%>"))
    )
   (t (progn 
        (if (= i 1) 
            (progn 
              (format t "~% ___________________________________________________________")
              (format t "~%/                        BLOKUS UNO                          \\")
              (format t "~%\\                   Escolha o Tabuleiro                      /")))
        (format t "~%/                     ~a - Tabuleiro ~a                       \\" i i) 
        (choose-board (+ i 1) (cdr boards))))
   )
  )

;;; Files Handler

;; get-problems-path
;  returns the path to the problems.dat file (D:/IPS/3� Ano/1� Semestre/Intelig�ncia Artificial/Blokus/problemas.dat)
(defun get-problems-path()
  (make-pathname :host "D" :directory '(:absolute "IPS" "3� Ano" "1� Semestre" "Intelig�ncia Artificial" "Blokus") :name "problemas" :type "dat")   
)

;; get-solutions-path
;  returns the path to the solutions.dat file (D:/IPS/3� Ano/1� Semestre/Intelig�ncia Artificial/Blokus/resultados.dat)
(defun get-results-path()
  (make-pathname :host "D" :directory '(:absolute "IPS" "3� Ano" "1� Semestre" "Intelig�ncia Artificial" "Blokus") :name "resultados" :type "dat")
)

;; load-problems-file
;  returns all boards of problemas.dat file
;  teste -> (load-problems-file)
(defun load-problems-file ()
  (with-open-file (stream (get-problems-path))
    (labels ((read-recursively ()
               (let ((line (read stream nil 'eof)))
                 (if (eq line 'eof)
                     nil
                     (cons line (read-recursively))))))
      (read-recursively))
    )
)




;;; User Handler

;; start
;; Receive data from the keyboard, by the user in relation to the option he want to choose
(defun start()
  (progn
    (init-menu)
    (let ((option (read)))
      (if (or (not (numberp option)) (< option 0) (> option 2))
          (progn (format t "Op��o inv�lida") (start))
        (case option
          ;('1 (progn (let ((solve (exec-search))) (print (caadr solve))) (start)))
          ('2 (progn (let ((board (read-board-chosen 'start))) (if (listp board) (print (second board)))) (start)))
          ('0 (format t "Adeus!"))
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
                (progn (format t "Op��o inv�lida")) (read-depth-chosen))
               (t option))))
)

;; read-heuristic-chosen
;  read the heuristic chosen by the user
(defun read-heuritic-chosen ()
  (if (not (choose-heuristic))
      (let ((option (read)))
         (cond ((eq option '0) );(exec-search))
               ((or (not (numberp option)) (< option 0)) 
                (progn (format t "Op��o inv�lida")) (read-heuritic-chosen))
               ;((eq option 1) 'base-heuristic)
               ;(T 'best-heuristic)
     )))
;)
)

;; read-board-chosen
;  read the board chosen by the user
(defun read-board-chosen(back)
  (progn (choose-board)
    (let ((option (read)))
      (cond ((eq option '0) (funcall back))
            ((not (numberp option)) 
             (progn (format t "Op��o inv�lida") (read-board-chosen back))) 
            (t (let ((boards-list (load-problems-file)))
                 (if (or (< option 0) (> option (length boards-list))) 
                     (progn (format t "Op��o inv�lida") (read-board back))
                   (list option (nth(1- option) boards-list))))))
      )
    )
  )

;; run-algorithm
;; run the algorithm chosen by the user
(defun run-algorithm ()
)





;; read-algorithm-chosen 
;  read the algorithm chosen by the user



;;;Stats

;; write-bfs-dfs-stats
;  write the solution and measures for the bfs and dfs algorithms
#|
(defun write-bfs-dfs-stats (search)
  (progn
    ;(format "~% *** Solu��o do Tabuleiro: ***")
    (format "")
    (format "~%~t> Algoritmo:")
    (format "~%~t> In�cio:")
    (format "~%~t> Fim:")
    (format "~%~t> Tempo Total:")
    (format "~%~t> Fator de ramifica��o m�dia:")
    (format "~%~t> N�mero de n�s gerados:")
    (format "~%~t> N�mero de n�s expandidos:")
    (format "~%~t> Penetr�ncia:")
    (if (eq search 'dfs)
        (format "~%~t> Profundidade m�xima:"))
    (format "~%~t> Comprimento da solu��o:")
    (format "~%~t> Estado Inicial:")
    ;fun��o para mostrar o estado inical do tabuleiro
    (format "~%~t> Estado Final:")
    ;fun��o para a solu��o do tabuleiro
   )
)
|#


;; write-a*-stats
;  write the solution and measures for the a* algorithm
#|
(defun write-a*-stats (search)
  (progn
    ;(format "~% *** Solu��o do Tabuleiro: ***")
    (format "")
    (format "~%~t> Algoritmo:")
    (format "~%~t> In�cio:")
    (format "~%~t> Fim:")
    (format "~%~t> Tempo Total:")
    (format "~%~t> Fator de ramifica��o m�dia:")
    (format "~%~t> N�mero de n�s gerados:")
    (format "~%~t> N�mero de n�s expandidos:")
    (format "~%~t> Penetr�ncia:")
    (format "~%~t> Comprimento da solu��o:")
    (format "~%~t> Estado Inicial:")
    ;fun��o para mostrar o estado inical do tabuleiro
    (format "~%~t> Estado Final:")
    ;fun��o para a solu��o do tabuleiro
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