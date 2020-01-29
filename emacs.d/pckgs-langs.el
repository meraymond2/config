;;;;;;;;;
;; LSP ;;
;;;;;;;;;

;; To use the LSP for a given language, install the binary first,
;; and put it on the PATH.
;; Make sure you can run clojure-lsp
;; C: https://github.com/MaskRay/ccls/wiki/Build
;;    Make sure ccls or clangd is on the PATH.
;; Clojure: https://github.com/snoe/clojure-lsp
;;          Make sure clojure-lsp is on the PATH.
;; Go: https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
;;     Make sure gopls is on the PATH>
(use-package lsp-mode
  :ensure t
  :commands lsp
  :config
  ;; add paths to your local installation of project mgmt tools, like lein
  (setenv "PATH" (concat
                   "/usr/local/bin" path-separator
                   (getenv "PATH")))
  :init
  (setq lsp-enable-indentation nil)
  (add-hook 'clojure-mode-hook #'lsp)
  (add-hook 'clojurec-mode-hook #'lsp)
  (add-hook 'clojurescript-mode-hook #'lsp)
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'c-mode-hook #'lsp)
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

;;;;;;;
;; C ;;
;;;;;;;
(add-hook 'c-mode-hook 'delete-trailing-whitespace)


;;;;;;;;;;;;;
;; Clojure ;;
;;;;;;;;;;;;;
(use-package clojure-mode
  :ensure t
  :mode ("\\.clj\\'" . clojure-mode)
  :init
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  :config
  (add-hook 'clojure-mode-hook
            (lambda ()
              (whitespace-mode)
              ))
  )

(use-package cider
  :ensure t)

(defun clojure-fmt-buffer
  ()
  (cider-format-buffer)
  (clojure-sort-ns)
  )

;;;;;;;;
;; Go ;;
;;;;;;;;
(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :init
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  )

;;;;;;;;;
;; Zig ;;
;;;;;;;;;
(use-package zig-mode
  :ensure t
  :mode ("\\.zig\\'" . zig-mode)
	:init
	(add-hook 'before-save-hook 'delete-trailing-whitespace)
	)
