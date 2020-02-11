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
  ("f" lsp-format-buffer "Format C buffer")
  ("g" lsp-find-definition "Go to definition")
  )

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

(global-set-key (kbd "M-SPC j") 'hydra-by-major-mode)

(defhydra hydra-window (global-map "M-SPC w")
  "Window hydra"
  ("f" other-window         "other-window")
  ("w" delete-window        "delete-window")
  ("W" delete-other-windows "delete-other-windows")

  ("h" windmove-left  "windmove-left")
  ("j" windmove-down  "windmove-down")
  ("k" windmove-up    "windmove-up")
  ("l" windmove-right "windmove-right")

  ("H" shrink-window-horizontally  "shrink-window-horizontally")
  ("J" shrink-window               "shrink-window")
  ("K" enlarge-window              "enlarge-window")
  ("L" enlarge-window-horizontally "enlarge-window-horizontally")
  
  ("2" split-window-below "split-window-below")
  ("3" split-window-right "split-window-right")
  )
