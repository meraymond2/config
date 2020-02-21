(load "~/.emacs.d/pckgs-general.el")
(load "~/.emacs.d/pckgs-langs.el")

(defhydra hydra-clojure ()
  "Clojure hydra"
  ("M-b" clojure-align "Balance expression")
  ("M-c" cider-repl-clear-buffer "Clear Repl")
  ("M-d" cider-doc "Show documentation")
  ("M-f" (clojure-fmt-buffer) "Format Clj buffer")
  ("M-g" (cider-find-var) "Go to definition")
  ("M-i" cider-jack-in "Start Repl" :exit t)
  ("M-l" cider-load-buffer "Load the current buffer")
  ("M-n" cider-repl-set-ns "Set the repl to the current ns")
  ("M-p" rainbow-delimiters-mode "Toggle rainbow parens")
  ("M-r" cider-ns-refresh "Refresh ns")
  ("M-t" cider-test-run-ns-tests "Run tests in ns")
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

(global-set-key (kbd "M-SPC M-j") 'hydra-by-major-mode)

(defhydra hydra-window (global-map "M-SPC M-w")
  "Window hydra"
  ("M-f" other-window         "other-window")
  ("M-w" delete-window        "delete-window")
  ("M-W" delete-other-windows "delete-other-windows")

  ;; Movement keys based on i3, not vim
  ("M-j" windmove-left  "windmove-left")
  ("M-k" windmove-down  "windmove-down")
  ("M-l" windmove-up    "windmove-up")
  ("M-;" windmove-right "windmove-right")

  ("M-J" shrink-window-horizontally  "shrink-window-horizontally")
  ("M-K" shrink-window               "shrink-window")
  ("M-L" enlarge-window              "enlarge-window")
  ("M-:" enlarge-window-horizontally "enlarge-window-horizontally")

  ("M-2" split-window-below "split-window-below")
  ("M-3" split-window-right "split-window-right")
  )

(defhydra hydra-projectile (global-map "M-SPC M-p")
  "Projectile hydra"
  ("M-b" projectile-switch-to-buffer "switch to buffer")
  ("M-d" projectile-switch-to-dir    "switch to dir")
  ("M-D" projectile-dired            "dired at root")
  ("M-f" projectile-find-file        "switch to file")
  ("M-k" projectile-kill-buffers     "kill active buffers")
  ("M-p" projectile-switch-project   "switch project")
  ("M-s" projectile-ripgrep          "grep in project")
  )
