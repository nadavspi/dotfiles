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

;; No blinking cursor
(blink-cursor-mode 0)

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

;; Theme
(use-package color-theme-sanityinc-tomorrow
  :ensure color-theme-sanityinc-tomorrow
  :init (color-theme-sanityinc-tomorrow-eighties))


;;; Key binds

;; C-x C-m  
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Indent on RET
(define-key global-map (kbd "RET") 'newline-and-indent)


;;; Evil mode
(defun evil-normal-and-save-buffer()
  (interactive)
  (evil-normal-state)
  (save-buffer))

(use-package evil
  :ensure evil

  :pre-load
  (setq evil-want-C-u-scroll t)

  :init
  (progn
    (use-package evil-leader
      :ensure evil-leader
      :init
      (progn
	(evil-leader/set-leader ",")
	(global-evil-leader-mode t)
	(evil-leader/set-key
	 "m" (lambda () (interactive) (message "Mode %s" major-mode)))))

    (use-package key-chord
      :ensure key-chord
      :init
      (progn
	(key-chord-mode t)
	(key-chord-define evil-insert-state-map "jk" 'evil-normal-and-save-buffer)
	(key-chord-define evil-visual-state-map "jk" 'evil-normal-and-save-buffer)))

    (use-package evil-surround
      :ensure evil-surround
      :commands global-evil-surround-mode
      :idle (global-evil-surround-mode t))

    (use-package evil-matchit
      :ensure evil-matchit
      :commands global-evil-matchit-mode
      :idle (global-evil-matchit-mode t)))

  :config
  (progn
    (evil-mode t)))
	
;; Magit

(use-package magit
  :ensure magit
  :commands (magit-status magit-log)
  :init
  (evil-leader/set-key
    "gs" 'magit-status))

;; Insert line above/below like in unimpaired
;(defun insert-blank-line-above ()
  ;(interactive)
  ;(evil-open-above 1)
  ;(evil-normal-state))
;(defun insert-blank-line-below ()
  ;(interactive)
  ;(evil-open-below 1)
  ;(evil-normal-state))
;(define-key evil-normal-state-map (kbd "[ SPC") 'insert-blank-line-above)
;(define-key evil-normal-state-map (kbd "] SPC") 'insert-blank-line-below)


;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure rainbow-delimiters 
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes (quote ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
