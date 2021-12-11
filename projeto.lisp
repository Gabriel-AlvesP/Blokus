;;;; Projeto.lip 
;;;; Carrega os outros ficheiros de codigo, escreve e le ficheiros e trata, ainda, da interacao com o utilizador
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318


;;; Menu

;; init-menu 
;  shows the game's initial menu
(defun init-menu()
"Mostra o menu inicial"
  (progn
  	(format t "~%___________________________________~%~%>")
    (format t "~%\            BLOKUS               / ")
    (format t "~%/                                 \ ")
    (format t "~%\  1 - Resolver um tabuleiro      /")
    (format t "~%/  2 - Mostrar um tabuleiro       \ ")
    (format t "~%\  3 - Sair                       /")
    (format t "~%/_________________________________\ ~%~%>")
  )
)


;;; Files Handler


;;; User Handler



;;;Stats

;; current-time
;  returns a list with a actual time (hours minutes seconds)
(defun current-time()
  (multiple-value-bind (seconds minutes hours) (get-decoded-time)
    (list hours minutes seconds)
   )
)