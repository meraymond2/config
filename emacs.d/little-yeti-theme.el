;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Face-Attributes.html

(defconst darker-gray "#222222")
(defconst dark-gray "#2b2b2b")
(defconst medium-gray "#383838")
(defconst medium-light-gray "#555555")
(defconst light-gray "#bbbbbb")

(defconst red "#e06c75")
(defconst orange "#e59400")
(defconst golden "#e5c07b")
(defconst green "#00ddad")
(defconst blue "#47B5E7")
(defconst purple "#b77ee0")
(defconst turquoise "#00afaf")

(defconst unknown "#000000")
(defconst temp "#FF00FF")

(deftheme little-yeti)
(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces 'little-yeti
  	;; Editor
  	;;; Basic text face
    `(default ((,class (:background ,dark-gray :foreground ,light-gray))))
    ;;; Cursor
    `(cursor ((,class (:background ,light-gray))))
    ;;; Selection face
    `(region ((,class (:background ,medium-gray :distant-foreground ,dark-gray))))
    ;;; Hover face
    `(highlight ((,class (:background ,medium-gray :distant-foreground ,dark-gray))))
    ;;; Current line face
    `(hl-line ((,class (:background ,darker-gray))))
    ;;; Current paren and match face
    `(show-paren-match ((,class (:background ,medium-light-gray))))
    `(show-paren-mismatch ((,class (:background nil :foreground ,red))))

    ;; Whitespace
    ;;; Default space mark style
	`(whitespace-space ((,class (:foreground ,medium-gray))))
	;;; Tab mark style
	`(whitespace-tab ((,class (:foreground ,medium-gray))))
	;;; Leading whitespace, but unfortunately not in dev modes
	`(whitespace-indentation ((,class (:foreground ,medium-gray))))
	;;; Trailing spaces
	`(whitespace-trailing ((,class (:foreground ,red))))
	;;; Unwanted spaces around tabs
	`(whitespace-space-after-tab ((,class (:foreground ,red))))
	`(whitespace-space-before-tab ((,class (:foreground ,red))))
	;;; Lines that are longer than the max-col-width
	`(whitespace-line ((,class (nil))))

	;;;........
	`(whitespace-big-indent ((,class (:background ,unknown :foreground ,unknown))))
	`(whitespace-empty ((,class (:background ,unknown :foreground ,unknown))))
	`(whitespace-hspace ((,class (:background ,unknown :foreground ,unknown))))
	`(whitespace-newline ((,class (:background ,unknown :foreground ,unknown))))

	;; Mini-buffer
	`(minibuffer-prompt ((,class (:height 100))))

	;; Linum/Fring
	;;; Linum numbers
	`(linum ((,class (:foreground ,medium-light-gray :height 100))))
	;;; Linum padding
	`(linum-padding ((,class (:background ,dark-gray :foreground ,dark-gray))))
	;;; Fringe colour
	`(fringe ((,class (:background ,medium-gray))))

	;; Modeline
	`(mode-line ((,class (:background ,dark-gray :height 100 :box (:color ,light-gray)))))
	`(mode-line-buffer-id ((,class (:foreground ,blue))))
	`(mode-line-inactive ((,class (:background ,dark-gray :height 100 :box (:color ,medium-gray)))))

	`(mode-line-emphasis ((,class (:background ,unknown))))
	`(mode-line-highlight ((,class (:background ,unknown))))

	;; General Code
	;;; Comment marker, e.g. ;; or //
	`(font-lock-comment-delimiter-face ((,class (:foreground ,medium-light-gray :slant italic))))
	;;; Comment text
	`(font-lock-comment-face ((,class (:foreground ,medium-light-gray :slant italic))))
	;;; Clojure: function name in definition, not usage
	;;; Go: function name in definition and usages
	;;; Zig: function name in definition, not usage
	`(font-lock-function-name-face ((,class (:foreground nil))))
	;;; Built in language keywords, like defn, import, var, etc.
	`(font-lock-keyword-face ((,class (:foreground ,red))))
	;;; Strings
	`(font-lock-string-face ((,class (:foreground ,golden))))
	;;; Clojure: ns name and package in package/func
	;;; Go/Zig: type names in declarations and arguments
	`(font-lock-type-face ((,class (:foreground ,turquoise))))
	;;; Clojure: names of def variables, not let though
	;;; Go: variables names, only in declarations using var or :=
	;;; Zig: variables names, only in declarations using var or :=
	`(font-lock-variable-name-face ((,class (:foreground nil))))
	;;; Clojure: nothing
	;;; Go: nothing
	;;; Zig: @builtIn functions
	`(font-lock-builtin-face ((,class (:foreground ,green))))
	;;; Clojure: docstrings
	;;; Zig: /// docstrings
	`(font-lock-doc-face ((,class (:foreground ,medium-light-gray :slant italic))))
	;;; Clojure: true/false
	;;; Go, true/false, nil, and key-names when building, not defining, structs
	;;; Zig: undefined and null, true/false
	`(font-lock-constant-face ((,class (:foreground nil, :slant italic))))
	;;; C: Preprocessor statements, such as #include
	`(font-lock-preprocessor-face ((,class (:foreground ,green))))
	;;;; ! negation symbols
	`(font-lock-negation-char-face ((,class (nil))))
	;;;; C: Unmatched quotes
	`(font-lock-warning-face ((,class (:underline (:color ,red)))))
	;;.......
	`(font-lock-regexp-grouping-backslash ((,class (:background ,unknown :foreground ,unknown))))
	`(font-lock-regexp-grouping-construct ((,class (:background ,unknown :foreground ,unknown))))

	;; Clojure
	`(clojure-character-face ((,class (:foreground ,golden))))
	`(clojure-keyword-face ((,class (:foreground ,purple))))

	;; Lsp
	;;; The expression being evaluated, normally the one under the cursor
	`(lsp-face-highlight-textual ((,class (nil))))
	;;; Highlights where the symbol is being read in the code (C).
	`(lsp-face-highlight-read ((,class (:underline (:color ,blue)))))
	;;; Highlights symbols being written to, it seems to highlight
	;;; mutation/reassignment of the symbol under the pointer, in C
	`(lsp-face-highlight-write ((,class (:underline (:color ,red)))))

	;;.......
	`(lsp-face-semhl-constant ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-deprecated ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-enummember ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-field ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-field-static ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-function ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-method ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-namespace ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-preprocessor ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-static-method ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-type-class ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-type-enum ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-type-primitive ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-type-template ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-type-typedef ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-variable ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-variable-local ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-face-semhl-variable-parameter ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-lens-face ((,class (:background ,unknown :foreground ,unknown))))
	`(lsp-lens-mouse-face ((,class (:background ,unknown :foreground ,unknown))))

	;; Smart Parens
	;;; Highlights the selection in new parens.
	`(sp-pair-overlay-face ((,class (nil))))

	;;.......
	`(sp-show-pair-enclosing ((,class (:background ,unknown :foreground ,unknown))))
	`(sp-show-pair-mismatch-face ((,class (:background ,unknown :foreground ,unknown))))
	`(sp-show-pair-match-content-face ((,class (:background ,unknown :foreground ,unknown))))
	`(sp-show-pair-match-face ((,class (:background ,unknown :foreground ,unknown))))
	`(sp-wrap-overlay-closing-pair ((,class (:background ,unknown :foreground ,unknown))))
	`(sp-wrap-overlay-face ((,class (:background ,unknown :foreground ,unknown))))
	`(sp-wrap-overlay-opening-pair ((,class (:background ,unknown :foreground ,unknown))))
	`(sp-wrap-tag-overlay-face ((,class (:background ,unknown :foreground ,unknown))))

	;; Rainbow Parens
	`(rainbow-delimiters-depth-1-face ((,class (:foreground ,blue))))
	`(rainbow-delimiters-depth-2-face ((,class (:foreground ,purple))))
	`(rainbow-delimiters-depth-3-face ((,class (:foreground ,green))))
	`(rainbow-delimiters-depth-4-face ((,class (:foreground ,blue))))
	`(rainbow-delimiters-depth-5-face ((,class (:foreground ,purple))))
	`(rainbow-delimiters-depth-6-face ((,class (:foreground ,green))))
	`(rainbow-delimiters-depth-7-face ((,class (:foreground ,blue))))
	`(rainbow-delimiters-depth-8-face ((,class (:foreground ,purple))))
	`(rainbow-delimiters-depth-9-face ((,class (:foreground ,green))))

	;; Flymake
	`(flymake-error ((,class (:underline (:style wave :color ,red)))))
	`(flymake-note ((,class (:underline (:style wave :color ,green)))))
	`(flymake-warning ((,class (:underline (:style wave :color ,golden)))))

	;; Company Mode
	;;; Popup background
	`(company-tooltip ((,class (:background ,medium-gray))))
	;;; Selected option
	`(company-tooltip-selection ((,class (:background ,medium-light-gray))))
	;;; Match portion of option
	`(company-tooltip-common ((,class (:foreground ,blue))))
	;;; Match portion of selected option
	`(company-tooltip-common-selection ((,class (:foreground ,green))))
	;;; Hovered option
	`(company-tooltip-mouse ((,class (:background ,medium-light-gray))))
	;;; Right char if scrolling
	`(company-scrollbar-bg ((,class (:background ,medium-gray :foreground ,medium-gray))))
	`(company-scrollbar-fg ((,class (:background ,medium-light-gray :foreground ,medium-light-gray))))
	;;; C: Additional information about the symbol to insert
	`(company-tooltip-annotation ((,class (:foreground ,turquoise))))
	`(company-tooltip-annotation-selection ((,class (:foreground ,turquoise))))

	;;; .........
	`(company-echo ((,class (:background ,unknown :foreground ,temp))))
	`(company-echo-common ((,class (:background ,unknown :foreground ,temp))))
	`(company-preview ((,class (:background ,unknown :foreground ,temp))))
	`(company-preview-common ((,class (:background ,unknown :foreground ,temp))))
	`(company-preview-search ((,class (:background ,unknown :foreground ,temp))))
	`(company-template-field ((,class (:background ,unknown :foreground ,temp))))
	`(company-tooltip-search ((,class (:background ,unknown :foreground ,temp))))
	`(company-tooltip-search-selection ((,class (:background ,unknown :foreground ,temp))))

	;; Markdown
	`(markdown-bold-face ((,class (:foreground ,blue :weight extra-bold))))
	`(markdown-code-face ((,class (:background ,darker-gray))))
	;;; # at beginning of header line
	`(markdown-header-delimiter-face ((,class (:foreground ,red))))
	`(markdown-header-face-1 ((,class (:foreground ,red :weight extra-bold))))
	`(markdown-header-face-2 ((,class (:foreground ,red :weight extra-bold))))
	`(markdown-header-face-3 ((,class (:foreground ,red :weight extra-bold))))
	`(markdown-header-face-4 ((,class (:foreground ,red :weight extra-bold))))
	`(markdown-header-face-5 ((,class (:foreground ,red :weight extra-bold))))
	`(markdown-header-face-6 ((,class (:foreground ,red :weight extra-bold))))
	`(markdown-inline-code-face ((,class (:foreground ,green :background ,darker-gray))))
	`(markdown-italic-face ((,class (:foreground ,blue :slant italic))))
	;;; Name of language before code blocks
	`(markdown-language-keyword-face ((,class (:foreground ,blue))))
	;;; List numbers
	`(markdown-list-face ((,class (:foreground ,blue))))
	;;; Delimiter symbols, `_*
	`(markdown-markup-face ((,class (:foreground ,blue))))
	;;; It mistakenly assigns some text this face
	`(markdown-metadata-value-face ((,class (:foreground ,nil))))
	;;; Code in code blocks
	`(markdown-pre-face ((,class (:foreground ,green))))

	;;;...
	`(markdown-blockquote-face ((,class (:foreground ,unknown))))
	`(markdown-comment-face ((,class (:foreground ,unknown))))
	`(markdown-footnote-marker-face ((,class (:foreground ,unknown))))
	`(markdown-footnote-text-face ((,class (:foreground ,unknown))))
	`(markdown-gfm-checkbox-face ((,class (:foreground ,unknown))))
	`(markdown-header-face ((,class (:foreground ,unknown))))
	`(markdown-header-rule-face ((,class (:foreground ,unknown))))
	`(markdown-highlight-face ((,class (:foreground ,unknown))))
	`(markdown-hr-face ((,class (:foreground ,unknown))))
	`(markdown-html-attr-name-face ((,class (:foreground ,unknown))))
	`(markdown-html-attr-value-face ((,class (:foreground ,unknown))))
	`(markdown-html-entity-face ((,class (:foreground ,unknown))))
	`(markdown-html-tag-delimiter-face ((,class (:foreground ,unknown))))
	`(markdown-html-tag-name-face ((,class (:foreground ,unknown))))
	`(markdown-language-info-face ((,class (:foreground ,unknown))))
	`(markdown-line-break-face ((,class (:foreground ,unknown))))
	`(markdown-link-face ((,class (:foreground ,unknown))))
	`(markdown-link-title-face ((,class (:foreground ,unknown))))
	`(markdown-math-face ((,class (:foreground ,unknown))))
	`(markdown-metadata-key-face ((,class (:foreground ,unknown))))
	`(markdown-missing-link-face ((,class (:foreground ,unknown))))
	`(markdown-plain-url-face ((,class (:foreground ,unknown))))
	`(markdown-reference-face ((,class (:foreground ,unknown))))
	`(markdown-strike-through-face ((,class (:foreground ,unknown))))
	`(markdown-table-face ((,class (:foreground ,unknown))))
	`(markdown-url-face ((,class (:foreground ,unknown))))
  )
)

(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'little-yeti)
