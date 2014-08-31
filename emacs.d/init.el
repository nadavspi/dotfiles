(custom-set-variables
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes (quote ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))))
(custom-set-faces
 )

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
;(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Indent on RET
(define-key global-map (kbd "RET") 'newline-and-indent)

(define-key global-map (kbd "M-h") 'help)


;;; Evil mode
(defun evil-normal-and-save-buffer()
  (interactive)
  (evil-normal-state)
  (save-buffer))
(defun evil-window-keymaps (map)
  (define-key map (kbd "C-k") 'evil-window-up)
  (define-key map (kbd "C-j") 'evil-window-down)
  (define-key map (kbd "C-h") 'evil-window-left)
  (define-key map (kbd "C-l") 'evil-window-right))
(defun insert-blank-line-above ()
  (interactive)
  (evil-open-above 1)
  (evil-normal-state)
  (message nil))
(defun insert-blank-line-below ()
  (interactive)
  (evil-open-below 1)
  (evil-normal-state)
  (message nil))

(use-package evil
  :ensure evil
  :pre-load
  (setq evil-want-C-u-scroll t
	evil-want-C-w-in-emacs-state t)
  :init
  (progn
    (use-package evil-leader
      :ensure evil-leader
      :init
      (progn
	(evil-leader/set-leader ",")
	(global-evil-leader-mode t)

	(evil-leader/set-key
	 "m" (lambda () (interactive) (message "Mode %s" major-mode)))

	; switch to previously edited buffer
	(evil-leader/set-key
	  "," 'mode-line-other-buffer)))

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
    (evil-mode t)

    (setq evil-emacs-state-cursor  '("red" box))
    (setq evil-normal-state-cursor '("gray" box))
    (setq evil-visual-state-cursor '("gray" box))
    (setq evil-insert-state-cursor '("gray" bar))
    (setq evil-motion-state-cursor '("gray" box))

    (define-key evil-normal-state-map (kbd "gei")
      (lambda () (interactive) (find-file user-init-file)))
    (define-key evil-normal-state-map (kbd "geb")
      'eval-buffer)
    (define-key evil-normal-state-map (kbd "geh")
      (lambda () (interactive) (find-file "/etc/hosts")))

    (evil-ex-define-cmd "h" 'help)
    (evil-window-keymaps evil-normal-state-map)

    ;; Insert line above/below like in unimpaired
    (define-key evil-normal-state-map (kbd "[ SPC") 'insert-blank-line-above)
    (define-key evil-normal-state-map (kbd "] SPC") 'insert-blank-line-below)))

;; Use esc to get away from everything, like in vim
;; https://github.com/TheBB/dotfiles/blob/master/emacs/init.el
(defun bb/minibuffer-keyboard-quit ()
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key minibuffer-local-map [escape] 'bb/minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'bb/minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'bb/minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'bb/minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'bb/minibuffer-keyboard-quit)
	
;; Magit
(use-package magit
  :ensure magit
  :commands (magit-status magit-log)
  :init
  (evil-leader/set-key
    "gs" 'magit-status))

;; Ag
(use-package ag
  :ensure ag)

;; Helm
(use-package helm
  :ensure helm
  :init
  (global-set-key (kbd "C-x C-m") 'helm-M-x)
  (global-set-key (kbd "C-x C-b") 'helm-mini)
  (evil-leader/set-key
    "x" 'helm-M-x
    "f" 'helm-find-files
    "b" 'helm-mini)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  :config
  (progn
    (use-package helm-ag
      :ensure helm-ag)))

;; Ido
(use-package ido-ubiquitous
  :ensure ido-ubiquitous)

(use-package flx-ido
  :ensure flx-ido)

(use-package ido-vertical-mode
  :ensure ido-vertical-mode)

(ido-mode t)
(ido-everywhere t)
(flx-ido-mode t)
(ido-vertical-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; Projectile
(use-package projectile
  :ensure projectile
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :ensure helm-projectile
  :init
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile))


;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure rainbow-delimiters 
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Show Paren Mode
(show-paren-mode 1)
