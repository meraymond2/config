;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(require 'srefactor)
(require 'srefactor-lisp)
(require 'geiser)
(require 'lsp-mode)

;; Set font globally
(set-face-font 'default "Source Code Pro-13")

;;;;;;;;;;;;;;;;;;;;;;;
;; Chicken ;;
;;;;;;;;;;;;;;;;;;;;;;;
(set-variable (quote scheme-program-name)
              "chicken-csi")
(setq geiser-chicken-binary "chicken-csi")
(setq geiser-active-implementations '(chicken))
(setq geiser-debug-jump-to-debug-p nil) ;; broken
;(setq geiser-debug-show-debug-p nil)
(setq geiser-repl-use-other-window nil)

(defun indent-buffer()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max))))

(add-hook 'scheme-mode-hook
          (lambda ()
            (smartparens-strict-mode)
            (map! :leader :nv
                  "j"
                  nil
                  (:prefix "j"
                    :n "f" #'indent-buffer
                    :n "i" #'geiser
                    :n "l" #'geiser-load-current-buffer
                    ))
            (global-set-key (kbd "C-M-<right>")
                            'sp-forward-slurp-sexp)
            (global-set-key (kbd "C-M-<left>")
                            'sp-backward-slurp-sexp)
            (global-set-key (kbd "C-M-<up>")
                            'sp-backward-barf-sexp)
            (global-set-key (kbd "C-M-<down>")
                            'sp-forward-barf-sexp)))

;;;;;;;;;;;;;
;; Clojure ;;
;;;;;;;;;;;;;

(add-hook 'clojure-mode-hook
          (lambda ()
            (smartparens-strict-mode)
            (map! :leader :nv
                  "j"
                  nil
                  (:prefix "j"
                    :n "f" #'cider-format-buffer
                    :n "i" #'cider-jack-in
                    :n "l" #'cider-load-buffer
                    :n "n" #'cider-repl-set-ns
                    ))
            (global-set-key (kbd "C-M-<right>")
                            'sp-forward-slurp-sexp)
            (global-set-key (kbd "C-M-<left>")
                            'sp-backward-slurp-sexp)
            (global-set-key (kbd "C-M-<up>")
                            'sp-backward-barf-sexp)
            (global-set-key (kbd "C-M-<down>")
                            'sp-forward-barf-sexp)))

;;;;;;;;
;; Go ;;
;;;;;;;;

(add-hook 'go-mode-hook
          (lambda ()
            (map! :leader :nv
                  "j"
                  nil
                  (:prefix "j"
                    :n "d" #'godoc-at-point
                    :n "e" #'flymake-mode
                    :n "f" #'gofmt
                    :n "j" #'godef-jump
                    ))
            (lsp)))

;;;;;;;;;;;;
;; Elixir ;;
;;;;;;;;;;;;

(add-hook 'elixir-mode-hook
          (lambda ()
            (map! :leader :nv
                  "j"
                  nil
                  (:prefix "j"
                    :n "f" #'elixir-format
                    :n "j" #'alchemist-goto-definition-at-point
                    :n "i" #'alchemist-iex-run
                    ))
            (alchemist-mode)
            (smartparens-strict-mode)))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(defun use-prettier-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (prettier (and root
                      (expand-file-name "node_modules/prettier/bin-prettier.js"
                                        root))))
    (when (and prettier (file-executable-p prettier))
      (setq-local prettier-js-command prettier))))

(add-hook 'typescript-mode-hook
          (lambda ()
            (map! :leader :nv
                  "j"
                  nil
                  (:prefix "j"
                    :n "e" #'lsp-ui-flycheck-list
                    :n "f" #'prettier-js
                    ))
            (lsp)
            (flycheck-add-mode 'javascript-eslint 'typescript-mode)
            (use-eslint-from-node-modules)
            (prettier-js-mode)
            (use-prettier-from-node-modules)
                      ))
