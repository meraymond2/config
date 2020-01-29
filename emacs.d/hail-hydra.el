(load "~/.emacs.d/pckgs-general.el")
(load "~/.emacs.d/pckgs-langs.el")

(defhydra hydra-clojure ()
  "Clojure hydra"
  ("b" clojure-align "Balance Clj expression")
  ("c" cider-repl-clear-buffer "Clear Repl")
  ("f" (clojure-fmt-buffer) "Format Clj buffer")
  ("g" (cider-find-var) "Go to definition")
  ("i" cider-jack-in "Start Repl" :exit t)
  ("l" cider-load-buffer "Load the current buffer")
  ("q" cider-doc "Show documentation")
  ("r" cider-ns-refresh "Refresh ns")
  ("t" cider-test-run-ns-tests "Run tests in ns")
  )

(defhydra hydra-go ()
  "Go hydra"
  ("f" gofmt "gofmt")
  ("g" godef-jump "Go to definition")
  ("q" godoc-at-point "Show documentation")
  )

(defhydra hydra-c ()
  "C hydra"
  ("f" lsp-format-buffer "Format C buffer"))

(defun hydra-by-major-mode ()
  (interactive)
  (cl-case major-mode
    (c-mode
      (hydra-c/body))
    (clojure-mode
     (hydra-clojure/body))
    (go-mode
     (hydra-go/body))
    (t
     (error "%S not supported" major-mode))))

(global-set-key (kbd "C-j") 'hydra-by-major-mode)
