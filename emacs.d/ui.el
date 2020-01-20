;; Settings fonts works differently in client/server mode.
(defvar default-font "Source Code Pro-15")	
(add-to-list 'default-frame-alist `(font . ,default-font))

(load-theme 'tsdh-dark)