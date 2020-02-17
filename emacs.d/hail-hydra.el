(load "~/.emacs.d/pckgs-general.el")
(load "~/.emacs.d/pckgs-langs.el")

(defhydra hydra-clojure ()
  "Clojure hydra"
  ("b" clojure-align "Balance expression")
  ("c" cider-repl-clear-buffer "Clear Repl")
  ("d" cider-doc "Show documentation")
  ("f" (clojure-fmt-buffer) "Format Clj buffer")
  ("g" (cider-find-var) "Go to definition")
  ("i" cider-jack-in "Start Repl" :exit t)
  ("l" cider-load-buffer "Load the current buffer")
  ("n" cider-repl-set-ns "Set the repl to the current ns")
  ("p" rainbow-delimiters-mode "Toggle rainbow parens")
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
    (cider-repl-mode
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

  ;; Movement keys based on i3, not vim
  ("j" windmove-left  "windmove-left")
  ("k" windmove-down  "windmove-down")
  ("l" windmove-up    "windmove-up")
  (";" windmove-right "windmove-right")

  ("J" shrink-window-horizontally  "shrink-window-horizontally")
  ("K" shrink-window               "shrink-window")
  ("L" enlarge-window              "enlarge-window")
  (":" enlarge-window-horizontally "enlarge-window-horizontally")

  ("2" split-window-below "split-window-below")
  ("3" split-window-right "split-window-right")
  )
