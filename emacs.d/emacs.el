;; Remove the menu bar
(menu-bar-mode -1)

;; Remove the tool bar
(tool-bar-mode -1)

;; Remove the scroll bars
(scroll-bar-mode -1)

;; Show line numbers
(global-linum-mode)

;;; Cursor
;; Make the cursor a line rather than a box
(setq-default cursor-type 'bar)

;; Move all backups to a single location, rather
;; than littering the working dirs
(setq backup-directory-alist
  `(("." . ,(concat user-emacs-directory "backups"))))

;; Make tabs display as two spaces
(setq-default tab-width 2)

;; Wrap lines sensibly, not in the middle of words
(global-visual-line-mode t)

;; Set which whitespace to display
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
