;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Nadav Spiegelman"
      user-mail-address "me@nadav.name")

(setq doom-theme 'doom-one)
(setq org-directory "~/org/")
(setq projectile-project-search-path '("~/src"))

(setq display-line-numbers-type 'relative
      undo-limit 80000000
      auto-save-default t
      scroll-margin 2)

(setq which-key-idle-delay 0.5)

(use-package evil-colemak-basics
  :init
  (setq evil-colemak-basics-layout-mod 'mod-dh)
  :config
  (global-evil-colemak-basics-mode))

(after! avy
  (setq avy-keys '(?n ?e ?i ?s ?t ?r ?i ?a)))
