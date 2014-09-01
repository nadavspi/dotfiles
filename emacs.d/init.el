(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#2d2d2d"))
 '(custom-enabled-themes (quote (sanityinc-solarized-light)))
 '(custom-safe-themes (quote ("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(fci-rule-color "#515151")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#f2777a") (40 . "#f99157") (60 . "#ffcc66") (80 . "#99cc99") (100 . "#66cccc") (120 . "#6699cc") (140 . "#cc99cc") (160 . "#f2777a") (180 . "#f99157") (200 . "#ffcc66") (220 . "#99cc99") (240 . "#66cccc") (260 . "#6699cc") (280 . "#cc99cc") (300 . "#f2777a") (320 . "#f99157") (340 . "#ffcc66") (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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
  (setq mac-command-modifier 'meta)

  (set-face-attribute 'default nil :height 170)
  (set-default-font "input sans")
  (setq-default line-spacing 0.05)
  (setq-default word-wrap t)

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
  :init
  (color-theme-sanityinc-tomorrow-eighties)
  (defun dark ()
    (interactive)
    (color-theme-sanityinc-tomorrow-eighties)))

(use-package color-theme-sanityinc-solarized
  :ensure color-theme-sanityinc-solarized
  :init
  (defun light ()
    (interactive)
    (color-theme-sanityinc-solarized-light)))


;;; Key binds

;; C-x C-m
;(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Indent on RET
(define-key global-map (kbd "RET") 'newline-and-indent)

(define-key global-map (kbd "M-h") 'help)

(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-o") 'other-window)


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
  (evil-next-line)
  (message nil))
(defun insert-blank-line-below ()
  (interactive)
  (evil-open-below 1)
  (evil-normal-state)
  (evil-previous-line)
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

	; Fugitive-like git commands
	(evil-leader/set-key "ga"
	  (lambda () (interactive) (evil-ex "!git add %")))

	(evil-leader/set-key "gc"
	  (lambda () (interactive) (evil-ex "!git commit -m \"")))

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
      :idle (global-evil-matchit-mode t)
      :init
      (progn
	(defun evilmi-customize-keybinding ()
	  (evil-define-key 'normal evil-matchit-mode-map
	    (kbd "TAB") 'evilmi-jump-items))))

    (use-package evil-sneak
      :load-path "vendor/"))

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
      (lambda () (interactive) (find-file "/sudo::/etc/hosts")))

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
    "gs" 'magit-status
    "gp" 'magit-push))

;; Ag
;(use-package ag
;  :ensure ag)

;; Helm
(use-package helm
  :ensure helm
  :init
  ;(global-set-key (kbd "C-x C-b") 'helm-mini)
  (evil-leader/set-key "f" 'helm-find-files)
  (evil-leader/set-key "hb" 'helm-bookmarks)
  (define-key evil-normal-state-map (kbd "g h b") 'helm-bookmarks)
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

(evil-leader/set-key "b" 'ido-switch-buffer)

; sort ido filelist by mtime instead of alphabetically
(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
(defun ido-sort-mtime ()
  (setq ido-temp-list
	(sort ido-temp-list
	      (lambda (a b)
		(time-less-p
		 (sixth (file-attributes (concat ido-current-directory b)))
		 (sixth (file-attributes (concat ido-current-directory a)))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
	      (lambda (x) (and (char-equal (string-to-char x) ?.) x))
	      ido-temp-list))))

(ido-mode t)
(ido-everywhere t)
(ido-vertical-mode 1)
(flx-ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; Smex
(use-package smex
  :ensure smex
  :init
  (global-set-key (kbd "C-x C-m") 'smex)
  (evil-leader/set-key "x" 'smex))

;; Projectile
(use-package projectile
  :ensure projectile
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :ensure helm-projectile
  :init
  (define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file))

;; Flycheck
(use-package flycheck
  :ensure flycheck)

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure rainbow-delimiters
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Show Paren Mode
(show-paren-mode 1)

;; Smartparens
(use-package smartparens
  :ensure smartparens
  :idle
  (smartparens-global-mode t))

;; Google
(use-package google-this
  :ensure google-this
  :config
  (global-set-key (kbd "C-x g") 'google-this-mode-submap))

;; Writeroom
(use-package writeroom-mode
  :commands writeroom-mode)

;; Company
(use-package company
  :commands company-mode
  :ensure company
  :init (add-hook 'prog-mode-hook 'company-mode)
  :config
  (progn
    (setq company-idle-delay 0)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)))

;; Emmet
(use-package emmet-mode
  :ensure emmet-mode
  :commands emmet-mode
  :init
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode))

;; Scss mode
(use-package scss-mode
  :ensure scss-mode
  :config
  (setq scss-compile-at-save nil))

;; Rainbow mode for CSS
(use-package rainbow-mode
  :ensure rainbow-mode
  :config
  (add-hook 'css-mode-hook 'rainbow-mode))

;; Web mode
(use-package web-mode
  :ensure web-mode
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

    ;; make web-mode play nice with smartparens
    (setq web-mode-enable-auto-pairing nil)))
