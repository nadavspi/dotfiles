(require 'org)
(org-babel-load-file (concat (getenv "HOME") "/.emacs.d/emacs.org"))

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
