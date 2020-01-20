;;;;;;;;;
;; LSP ;;
;;;;;;;;;

;; To use the LSP for a given language, install the binary first,
;; and put it on the PATH. 
(use-package lsp-mode
  :ensure t
  :commands lsp
  :config
  ;; add paths to your local installation of project mgmt tools, like lein
  (setenv "PATH" (concat
                   "/usr/local/bin" path-separator
                   (getenv "PATH")))
  (dolist (m '(clojure-mode
               clojurec-mode
               clojurescript-mode
               clojurex-mode))
     (add-to-list 'lsp-language-id-configuration `(,m . "clojure")))
  :init
  (setq lsp-enable-indentation nil)
  (add-hook 'clojure-mode-hook #'lsp)
  (add-hook 'clojurec-mode-hook #'lsp)
  (add-hook 'clojurescript-mode-hook #'lsp))

;;;;;;;;;;;;;
;; Clojure ;;
;;;;;;;;;;;;;
(use-package clojure-mode
  :ensure t
  :mode ("\\.clj\\'" . clojure-mode))

;; Define a new face
; (defface clojure-function-face
;   '((t (:foreground "OrangeRed1")))
;   "Testing."
;   :group 'font-lock-faces)

;; Use that new face to highlight based on a regexp
;; I haven’t gotten the regex for Clojure functions yet
;; because emacs has the worst regex syntax in the world.
; (font-lock-add-keywords 'clojure-mode
  ; '(
    ; ("\\<\\(FIXME\\):" 1 'clojure-function-face prepend)
    ; )
  ; )

(use-package cider
  :ensure t
  :mode ("\\.clj\\'" . clojure-mode))

(defun init-smartparens
  ()
  (smartparens-strict-mode)
  (local-set-key (kbd "C-M-<right>") 'sp-forward-slurp-sexp)
  (local-set-key (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
  (local-set-key (kbd "C-M-<up>") 'sp-backward-barf-sexp)
  (local-set-key (kbd "C-M-<down>") 'sp-forward-barf-sexp))

(use-package smartparens
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'init-smartparens)
  (add-hook 'clojure-mode-hook 'init-smartparens)
  (add-hook 'cider-repl-mode-hook 'init-smartparens)
  (add-hook 'clojurec-mode-hook 'init-smartparens)
  (add-hook 'clojurescript-mode-hook 'init-smartparens))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'clojurec-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'clojurescript-mode-hook 'rainbow-delimiters-mode)
  )

;; For autocompletion pop up.
(use-package company-lsp
  :ensure t
  :commands company-lsp
  ;; Never pop up automatically, trigger manually with M-TAB
  :init
  (setq company-idle-delay nil)
  (global-set-key (kbd "<backtab>") 'company-lsp)
  )

;; Might be useful, but needs config, otherwise it's too annoying
; (use-package lsp-ui
;   :ensure t
;   :commands lsp-ui-mode)
