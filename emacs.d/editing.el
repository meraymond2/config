; (use-package multiple-cursors
;   :ensure t)

;; Sets the difference between two elements to the correct
;; amount of whitespace.
(global-set-key (kbd "C-M-<backspace>") 'fixup-whitespace)

;; Overwrite selection
(delete-selection-mode 1)