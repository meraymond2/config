;; Allows installing of packages from Melpa
;; http://melpa.org/#/getting-started
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; https://github.com/jwiegley/use-package for documentation
;; The first time emacs is loaded, this must be installed manually
;; with `package-refresh-contents`, `package-install`, `use-package`
;; then restart.
(eval-when-compile
  (require 'use-package))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

(use-package swiper
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'swiper))