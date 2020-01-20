;; Remove the menu bar
(setq menu-bar-mode nil)

;; Remove the tool bar
(setq tool-bar-mode nil)

;; Show line numbers
(global-linum-mode)

;;; Cursor
;; Make the cursor a line rather than a box
(setq-default cursor-type 'bar)

;; Move all backups to a single location, rather
;; than littering the working dirs
(setq backup-directory-alist
  `(("." . ,(concat user-emacs-directory "backups"))))

;; Show whitespace
(global-whitespace-mode)
(setq whitespace-style 
	  '(face 
	  	tabs 
	  	spaces 
	  	trailing 
	  	lines 
	  	space-before-tab 
	  	newline 
	  	indentation 
	  	; empty 
	  	space-after-tab 
	  	space-mark 
	  	tab-mark 
	  	; newline-mark
	  	))
