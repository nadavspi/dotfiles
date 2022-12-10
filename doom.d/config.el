;;; $DOOMDIR/aonfig.el -*- lexical-binding: t; -*-
(setq user-full-name "Nadav Spiegelman"
      user-mail-address "me@nadav.name")

(setq doom-theme 'doom-one)
(setq org-directory "~/org/")
(setq projectile-project-search-path '("~/src"))

(setq doom-font (font-spec :family "Ubuntu Mono" :size 24 :weight 'normal))

(setq display-line-numbers-type 'relative
      undo-limit 80000000
      auto-save-default t
      scroll-margin 2)

(setq which-key-idle-delay 0.5)

(use-package! obsidian
  :ensure t
  :demand t
  :config
  (obsidian-specify-path "~/Documents/Notes")
  (global-obsidian-mode t))

(use-package! super-save
  :config
  (setq super-save-auto-save-when-idle t)
   (super-save-mode +1))
(setq auto-save-default nil)

(after! avy
  (setq avy-keys '(?n ?e ?i ?s ?t ?r ?i ?a)))

(after! evil
  ;; map multiple states at once (courtesy of Michael Markert;
  ;; http://permalink.gmane.org/gmane.emacs.vim-emulation/1674)
  (defun set-in-all-evil-states (key def &optional maps)
    (unless maps
      (setq maps (list evil-normal-state-map
                       evil-visual-state-map
                       evil-insert-state-map
                       evil-emacs-state-map
                       evil-motion-state-map)))
    (while maps
      (define-key (pop maps) key def)))

  (defun set-in-all-evil-states-but-insert (key def)
    (set-in-all-evil-states key def (list evil-normal-state-map
                                          evil-visual-state-map
                                          evil-emacs-state-map
                                          evil-motion-state-map)))
  ;; colemak stuff
  (set-in-all-evil-states-but-insert "e" 'evil-previous-line)
  (set-in-all-evil-states-but-insert "n" 'evil-next-line)
  (set-in-all-evil-states-but-insert "i" 'evil-forward-char)
  (set-in-all-evil-states-but-insert "m" 'evil-backward-char)

  (set-in-all-evil-states-but-insert "U" 'evil-insert-line)
  (set-in-all-evil-states-but-insert "u" 'evil-insert)
  (set-in-all-evil-states-but-insert "l" 'evil-undo)

  (define-key evil-motion-state-map "k" 'evil-search-next)
  (define-key evil-motion-state-map "K" 'evil-search-previous)

  (define-key evil-motion-state-map "j" 'evil-forward-word-end)
  ;; (define-key evil-motion-state-map "J" 'evil-forward-WORD-end)

  (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)

  (setq evil-emacs-state-cursor  '("red" box))
  (setq evil-normal-state-cursor '("orange" box))
  (setq evil-visual-state-cursor '("green" box))
  (setq evil-insert-state-cursor '("orange" bar))
  (setq evil-replace-state-cursor '("orange" bar))
  (setq evil-operator-state-cursor '("orange" hollow))
  (setq evil-motion-state-cursor '("gray" box))

  ;; Easier window switching
  (defun evil-window-keymaps (map)
    (define-key map (kbd "C-e") 'evil-window-up)
    (define-key map (kbd "C-n") 'evil-window-down)
    (define-key map (kbd "C-m") 'evil-window-left)
    (define-key map (kbd "C-i") 'evil-window-right))
  (evil-window-keymaps evil-normal-state-map))
