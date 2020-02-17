;; Don’t show the welcome screen
(setq inhibit-startup-screen t)

;; Remove the menu bar
; (menu-bar-mode -1)

;; Remove the tool bar
; (tool-bar-mode -1)

;; Remove the scroll bars
(scroll-bar-mode -1)

;; Highlight current line
(global-hl-line-mode t)

;;; Cursor
;; Make the cursor a line rather than a box
(setq-default cursor-type 'bar)

;; Disable backups and autosaves
(setq backup-inhibited t)
(setq auto-save-default nil)

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

;; Show line numbers
(global-linum-mode t)

;; https://gist.github.com/whitlockjc/33fdf9bbdb9758dc2cbb
;; Custom face/function to pad the line number in a way that does not conflict with whitespace-mode
(defface linum-padding
  `((t :inherit 'linum
       :foreground ,(face-attribute 'linum :background nil t)))
  "Face for displaying leading zeroes for line numbers in display margin."
  :group 'linum)

(defun linum-format-func (line)
  (let ((w (length
            (number-to-string (count-lines (point-min) (point-max))))))
    (concat
     (propertize "  " 'face 'linum-padding)
     (propertize (make-string (- w (length (number-to-string line))) ?0)
                 'face 'linum-padding)
     (propertize (number-to-string line) 'face 'linum)
     (propertize "  " 'face 'linum-padding)
     )))

(setq linum-format 'linum-format-func)

(fringe-mode '(1 . 1))
