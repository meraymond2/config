
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

(use-package swiper
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'swiper))

(use-package hydra
  :ensure t)

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
  ;; Nice to have the option, not sure about enabling by default
  ; (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  ; (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  ; (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
  ; (add-hook 'clojurec-mode-hook 'rainbow-delimiters-mode)
  ; (add-hook 'clojurescript-mode-hook 'rainbow-delimiters-mode)
  )
