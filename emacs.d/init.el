;;; Package management

;; Set up package archives
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(require 'use-package)


;;; Basic settings

;; Remove scrollbars, menu bars, toolbars
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Quiet startup
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil)

;; Turn off alarms
(setq ring-bell-function 'ignore)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight current line (like cursorline)
(global-hl-line-mode t)

;; Line numbers
(setq linum-format "%3d ")
(add-hook 'prog-mode-hook 'linum-mode)
(use-package linum-relative
  :ensure linum-relative)

;; Font settings
(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :height 170)
  (set-default-font "input sans")
  (setq-default line-spacing 0.05)
  (toggle-word-wrap t)

  (defun use-proportional-font ()
    (interactive)
    (face-remap-add-relative 'default '(:family "Input Sans")))

  (defun use-monospace-font ()
    (interactive)
    (face-remap-add-relative 'default '(:family "Input Mono")))

(add-hook 'dired-mode-hook 'use-monospace-font) (add-hook 'magit-mode-hook 'use-monospace-font))


;;; Key binds
(add-hook 'after-init-hook '(lambda ()
  (global-set-key (kbd "C-x C-m") 'execute-extended-command)
))

;;; Evil mode

;; C-u to scroll
(setq evil-want-C-u-scroll t)

(require 'evil)

;; Insert line above/below like in unimpaired
(defun insert-blank-line-above ()
  (interactive)
  (evil-open-above 1)
  (evil-normal-state))
(defun insert-blank-line-below ()
  (interactive)
  (evil-open-below 1)
  (evil-normal-state))
(define-key evil-normal-state-map (kbd "[ SPC") 'insert-blank-line-above)
(define-key evil-normal-state-map (kbd "] SPC") 'insert-blank-line-below)

(evil-mode t)

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure rainbow-delimiters 
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

