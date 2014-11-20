(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#2d2d2d"))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes (quote ("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(evil-operator-comment-key "gc")
 '(fci-rule-color "#515151")
 '(linum-format (quote linum-relative))
 '(linum-relative-current-symbol "")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#f2777a") (40 . "#f99157") (60 . "#ffcc66") (80 . "#99cc99") (100 . "#66cccc") (120 . "#6699cc") (140 . "#cc99cc") (160 . "#f2777a") (180 . "#f99157") (200 . "#ffcc66") (220 . "#99cc99") (240 . "#66cccc") (260 . "#6699cc") (280 . "#cc99cc") (300 . "#f2777a") (320 . "#f99157") (340 . "#ffcc66") (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip ((t (:background "cornsilk" :foreground "black" :family "Input Mono"))))
 '(nxml-attribute-value ((t (:inherit font-lock-string-face :family "Input Mono"))) t))
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

;; Use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(modify-all-frames-parameters '((fullscreen . maximized)))

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; No blinking cursor
(blink-cursor-mode 0)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight current line (like cursorline)
(global-hl-line-mode t)

(setq default-indicate-empty-lines t)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq c-basic-indent 4)
(setq tab-width 4)

;; Line numbers
(setq linum-format "%3d ")
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'css-mode-hook 'linum-mode)
(add-hook 'sgml-mode-hook 'linum-mode)
(use-package linum-relative
  :ensure linum-relative
  :init
  (setq linum-format 'linum-relative))
(global-linum-mode 1)

;; Uniquify buffers with the same name
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; Font settings
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)

  (set-face-attribute 'default nil :height 170)
  (set-default-font "input sans")
  (setq-default line-spacing 0.25)
  (setq-default word-wrap t)

  (defun use-proportional-font ()
    (interactive)
    (face-remap-add-relative 'default '(:family "Input Sans")))

  (defun use-monospace-font ()
    (interactive)
    (face-remap-add-relative 'default '(:family "Input Mono")))

  (add-hook 'dired-mode-hook 'use-monospace-font)
  (add-hook 'help-mode-hook 'use-monospace-font)
  (add-hook 'magit-mode-hook 'use-monospace-font))

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

;; Useful stuff from Magnars
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (indent-buffer))

;;; Key binds

;; C-x C-m
                                        ;(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Indent on RET
(define-key global-map (kbd "RET") 'newline-and-indent)

(define-key global-map (kbd "M-h") 'help)

;; Splits
(defun split-and-switch-horizontally ()
  (interactive)
  (split-window-horizontally)
  (other-window 1))
(defun split-and-switch-vertically ()
  (interactive)
  (split-window-vertically)
  (other-window 1))

(global-set-key (kbd "M-3") 'split-and-switch-horizontally)
(global-set-key (kbd "M-2") 'split-and-switch-vertically)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-o") 'other-window)

;;; Exec-path-from-shell
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :ensure exec-path-from-shell
    :init
    (exec-path-from-shell-initialize)))

;;; Agressive indent mode
(use-package aggressive-indent
  :ensure aggressive-indent
  :config
  (progn
    (eval-after-load 'scss-mode
      '(add-hook
        'scss-mode-hook
        (lambda () (unless defun-prompt-regexp
                     (setq-local defun-prompt-regexp "^[^[:blank:]].*")))))
    (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
    (add-hook 'css-mode-hook #'aggressive-indent-mode)))

;;; YASnippet
(use-package yasnippet
  :ensure yasnippet
  :config
  (progn
    (yas-global-mode 1)))

;;; Column marker
(use-package column-marker
  :ensure column-marker
  :config
  (progn
    (column-marker-1 80)
    (column-marker-2 120)))

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
        (evil-leader/set-leader "SPC")
        (setq evil-leader/in-all-states)
        (global-evil-leader-mode t)

        (evil-leader/set-key "h" 'help)
        (evil-leader/set-key "w" 'save-buffer)

        (evil-leader/set-key "c" 'cleanup-buffer)

        (evil-leader/set-key
          "m" (lambda () (interactive) (message "Mode %s" major-mode)))

                                        ; Fugitive-like git commands
        (evil-leader/set-key "gc"
          (lambda ()
            (interactive)
            (minibuffer-with-setup-hook
                (lambda () (backward-char 1))
              (evil-ex "!git commit -m \"\""))))

                                        ; switch to previously edited buffer
        (evil-leader/set-key
          "SPC" 'mode-line-other-buffer)
        (define-key evil-normal-state-map (kbd ",,") 'mode-line-other-buffer)))

    (use-package key-chord
      :ensure key-chord
      :init
      (progn
        (key-chord-mode t)
        (key-chord-define evil-insert-state-map "jk" 'evil-normal-and-save-buffer)
        (key-chord-define evil-visual-state-map "jk" 'evil-normal-and-save-buffer)

        (key-chord-define-global "0o" ")")
        (key-chord-define-global "9i" "(")))

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
      :load-path "vendor/")

    (use-package evil-linewise
      :load-path "mine/evil-linewise/")

    (use-package evil-jumper
      :ensure evil-jumper)

    (use-package evil-operator-comment
      :load-path "vendor/"
      :config
      (progn
        (global-evil-operator-comment-mode 2))))


  :config
  (progn
    (evil-mode t)

    (setq evil-emacs-state-cursor  '("red" box))
    (setq evil-normal-state-cursor '("orange" box))
    (setq evil-visual-state-cursor '("green" box))
    (setq evil-insert-state-cursor '("orange" bar))
    (setq evil-replace-state-cursor '("orange" bar))
    (setq evil-operator-state-cursor '("orange" hollow))
    (setq evil-motion-state-cursor '("gray" box))

    ;; make j and k into gj and gk
    ;; (define-key evil-normal-state-map (kbd "j") 'evil-next-line)
    ;; (define-key evil-normal-state-map (kbd "k") 'evil-previous-line)



    ;; swap colon and semicolon
    (define-key evil-normal-state-map (kbd ";") 'evil-ex)
    (define-key evil-visual-state-map (kbd ";") 'evil-ex)
    (define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)

    (define-key evil-insert-state-map "\C-e" 'end-of-line)

    (define-key evil-insert-state-map (kbd "M-RET")
      (lambda ()
        (interactive)
        (end-of-line)
        (newline-and-indent)))

    (define-key evil-normal-state-map (kbd "gei")
      (lambda () (interactive) (find-file user-init-file)))
    (define-key evil-normal-state-map (kbd "geb")
      'eval-buffer)
    (define-key evil-normal-state-map (kbd "geh")
      (lambda () (interactive) (find-file "/sudo::/etc/hosts")))

    (evil-ex-define-cmd "h" 'help)
    (evil-ex-define-cmd "n" 'evil-ex-normal)
    (evil-window-keymaps evil-normal-state-map)))

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
  (use-package magit-magic
    :load-path "mine/")

  :config
  (evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
    "K" 'magit-discard-item
    "L" 'magit-key-mode-popup-logging)
  (evil-add-hjkl-bindings magit-status-mode-map 'emacs
    "K" 'magit-discard-item
    "l" 'magit-key-mode-popup-logging
    "h" 'magit-toggle-diff-refine-hunk)
  (evil-add-hjkl-bindings magit-log-mode-map 'emacs)
  (evil-add-hjkl-bindings magit-commit-mode-map 'emacs)

  ;; full screen magit-status
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))

  (defadvice magit-mode-quit-window (after magit-restore-screen activate)
    "Restores the previous window configuration and kills the magit buffer"
    (jump-to-register :magit-fullscreen))

  (define-key magit-status-mode-map (kbd "q") 'magit-mode-quit-window)

  (evil-set-initial-state 'git-commit-mode 'insert))
;; Ag
                                        ;(use-package ag
                                        ;  :ensure ag)

;; Move-text
(use-package move-text
  :ensure move-text)

;; Recentf
(use-package recentf
  :pre-load
  ;; disable auto cleanup because of tramp
  (setq recentf-auto-cleanup 'never)
  :config
  (progn
    (recentf-mode 1)
    (setq recentf-max-menu-items 100)))

;; Helm
(use-package helm
  :ensure helm
  :config
  (progn
    ;; (evil-leader/set-key "b" 'helm-buffers-list)
    (evil-leader/set-key "b" 'helm-mini)
    (evil-leader/set-key "f" 'helm-find-files)
    (evil-leader/set-key "r" 'helm-recentf)

    (global-set-key (kbd "C-x C-m") 'helm-M-x)
    (evil-leader/set-key "x" 'helm-M-x)


    (define-key evil-normal-state-map (kbd "ghb") 'helm-bookmarks)
    (define-key evil-normal-state-map (kbd "g h i") 'helm-semantic-or-imenu)
    (define-key evil-normal-state-map (kbd "g h o") 'helm-occur)

    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-z") 'helm-select-action)
    (use-package helm-ag
      :ensure helm-ag)))

;; Ido
(use-package ido-ubiquitous
  :ensure ido-ubiquitous
  :config (ido-ubiquitous-mode 1))

(use-package flx-ido
  :ensure flx-ido)

(use-package ido-vertical-mode
  :ensure ido-vertical-mode)

;; (evil-leader/set-key "b" 'ido-switch-buffer)

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
  :disabled
  :init
  (global-set-key (kbd "C-x C-m") 'smex)
  (evil-leader/set-key "x" 'smex))

;; Projectile
(use-package projectile
  :ensure projectile
  :config
  (progn
    (projectile-global-mode)
    (evil-leader/set-key "a g" 'projectile-ag)
    (setq projectile-enable-caching t)))

(use-package helm-projectile
  :ensure helm-projectile
  :init
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile)
  :config
  (progn
    (setq projectile-completion-system 'helm)
    (helm-projectile-on)
    (setq helm-projectile-sources-list '(helm-source-projectile-projects
                                         helm-source-projectile-files-list))
    (setq projectile-switch-project-action 'helm-projectile)
    ))

;; Flycheck
(use-package flycheck
  :ensure flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure rainbow-delimiters
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Show Paren Mode
(show-paren-mode 1)

;; Smartparens
(use-package smartparens-config
  :ensure smartparens
  :config
  (progn
    (require 'smartparens-config)
    (setq sp-autoescape-string-quote nil)
    (defun prelude-smart-open-line-above ()
      "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
      (interactive)
      (move-beginning-of-line nil)
      (newline-and-indent)
      (forward-line -1)
      (indent-according-to-mode))
    (sp-pair "{" nil :post-handlers
             '(((lambda (&rest _ignored)
                  (prelude-smart-open-line-above)) "RET"))))
  :idle
  (smartparens-global-mode t))

;; Hippie expand
(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Expand region
(use-package expand-region
  :ensure expand-region
  :config
  (progn
    (evil-leader/set-key "e" 'er/expand-region)))

;; Writeroom
(use-package writeroom-mode
  :commands writeroom-mode)

;; Powerline
(use-package powerline
  :ensure powerline
  :init
  (use-package powerline-evil
    :ensure powerline-evil
    :config
    (powerline-evil-center-color-theme)))

;; Company
(use-package company
  :commands company-mode
  :ensure company
  :init
  (progn
    (add-hook 'css-mode-hook 'company-mode)
    (add-hook 'nxml-mode-hook 'company-mode)
    (add-hook 'prog-mode-hook 'company-mode))
  :config
  (progn
    (setq company-idle-delay 0)
    (define-key evil-insert-state-map (kbd "TAB") 'company-manual-begin)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)))

;; Emmet
(use-package emmet-mode
  :ensure emmet-mode
  :commands emmet-mode
  :init
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  (add-hook 'nxml-mode-hook  'emmet-mode)
  (add-hook 'web-mode-hook  'emmet-mode)
  :config
  (setq emmet-preview-default nil)
  (define-key evil-normal-state-map (kbd "C-e") 'emmet-expand-line)
  (define-key evil-insert-state-map (kbd "C-e") 'emmet-expand-line))

;; CSS mode
(use-package css-mode
  :ensure css-mode
  :config
  (setq css-indent-offset 2))

;; Scss mode
(use-package scss-mode
  :ensure scss-mode
  :config
  (progn
    (setq scss-compile-at-save nil)
    (add-hook 'scss-mode-hook 'flycheck-mode)
    (add-hook 'scss-mode-hook (lambda () (setq comment-start "// " comment-end "")))))

;; Rainbow mode for CSS
(use-package rainbow-mode
  :ensure rainbow-mode
  :config
  (add-hook 'css-mode-hook 'rainbow-mode))

(use-package js2-mode
  :ensure js2-mode
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))))

;; Web mode
(use-package web-mode
  :ensure web-mode
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

    (setq web-mode-code-indent-offset 4)
    (setq web-mode-markup-indent-offset 4)

    ;; make web-mode play nice with smartparens
    (setq web-mode-enable-auto-pairing nil)))

;; PHP mode
(use-package php-mode
  :commands php-mode
  :ensure php-mode)

(use-package diminish
  :ensure diminish
  :init
  (diminish 'visual-line-mode)
  :config
  (progn
    (eval-after-load "magit" '(diminish 'magit-auto-revert-mode))
    (eval-after-load "smartparens" '(diminish 'smartparens-mode))
    (eval-after-load "company" '(diminish 'company-mode))
    (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
    (eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
    (eval-after-load "projectile" '(diminish 'projectile-mode))))

;; Org mode
(use-package org
  :config
  (progn
    (add-hook 'org-mode-hook
              (lambda () (interactive)
                (org-indent-mode)
                (visual-line-mode)
                (setq org-clock-persist 'history)
                (linum-mode)))

    ;; Persistent clocking
    (setq org-clock-persist 'history)
    (org-clock-persistence-insinuate)

    ;; Keys
    (evil-define-key 'normal org-mode-map
                                        ; Todo
      "t" 'org-todo

                                        ; Clocking
      "gxi" 'org-clock-in
      "gxo" 'org-clock-out
      "gxx" 'org-clock-in-last
      "gxd" 'org-clock-display
      "gxr" 'org-clock-report)

    ;; Todo settings
    (setq org-todo-keywords
          (quote ((sequence "TODO(t)" "WAITING(w)" "|" "CANCELLED(c)" "DONE(d)"))))
    (setq org-log-done t)

    ;; (define-key evil-normal-state-map (kbd "gh") 'outline-up-heading)
    (define-key evil-normal-state-map (kbd "T") 'org-time-stamp)

    (mapcar (lambda (state)
              (evil-declare-key state org-mode-map
                (kbd "M-l") 'org-metaright
                (kbd "M-h") 'org-metaleft
                (kbd "M-k") 'org-metaup
                (kbd "M-j") 'org-metadown
                ;; (kbd "M-L") 'org-shiftmetaright
                ;; (kbd "M-H") 'org-shiftmetaleft
                ;; (kbd "M-K") 'org-shiftmetaup
                ;; (kbd "M-J") 'org-shiftmetadown
                (kbd "M-L") 'org-shiftright
                (kbd "M-H") 'org-shiftleft
                (kbd "M-K") 'org-shiftup
                (kbd "M-J") 'org-shiftdown
                (kbd "M-o") '(lambda () (interactive)
                               (evil-org-eol-call
                                '(lambda()
                                   (org-insert-heading)
                                   (org-metaright))))))
            '(normal insert))

    (use-package evil-org
      :disabled
      :load-path "vendor/evil-org")))

;; nxml mode
(setq
 nxml-child-indent 4
 nxml-attribute-indent 4
 nxml-slash-auto-complete-flag t)

;; HTML mode stuff
                                        ; Reindent after deleting tag
(defadvice sgml-delete-tag (after reindent-buffer activate)
  (cleanup-buffer))

;; CSS stuff
(defun duplicate-css-selector ()
  "Duplicates next selector and comma separates them"
  (interactive)
  (search-forward "{")
  (backward-delete-char 2)
  (insert ",")
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  (backward-delete-char 1)
  (insert " {"))
(define-key evil-normal-state-map (kbd "g d s") 'duplicate-css-selector)

(defun duplicate-opposite-css-property ()
  "Duplicates a CSS declaration and changes the property's direction from left to right, top to bottom, etc."
  (interactive)
  (evil-yank-line (point-at-bol) (point-at-eol) 'line)
  (evil-paste-after 1)
  (evil-forward-word-begin 2)
  (let ((x (current-word t t)))
    (kill-word 1)
    (cond ((equal "left" x) (insert "right"))
          ((equal "right" x) (insert "left"))
          ((equal "top" x) (insert "bottom"))
          ((equal "bottom" x) (insert "top")))))
(define-key evil-normal-state-map (kbd "g d p") 'duplicate-opposite-css-property)

(defun delete-the-tag ()
  "Switches to sgml-mode to delete the tag and switches back to web-mode"
  (interactive)
  (sgml-mode)
  (sgml-delete-tag 1)
  (web-mode))
(define-key evil-normal-state-map (kbd "g d t") 'delete-the-tag)

;; Magento stuff
(define-key evil-normal-state-map (kbd "g m h")
  (lambda ()
    (interactive)
    (start-process "magerun"
                   (get-buffer-create "*magerun*")
                   "magerun" "dev:template-hints")
    (message "Toggling template hints")))

;; Org-clock-statusbar-app
(defadvice org-clock-in (after org-clock-statusbar-app-in activate)
  (call-process "/usr/bin/osascript" nil 0 nil "-e" (concat "tell application \"org-clock-statusbar\" to clock in \"" org-clock-current-task "\"")))
(defadvice org-clock-out (after org-clock-statusbar-app-out activate)
  (call-process "/usr/bin/osascript" nil 0 nil "-e" "tell application \"org-clock-statusbar\" to clock out"))
