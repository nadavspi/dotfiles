(defgroup evil-sneak nil
  "vim-sneak emulation for Emacs"
  :prefix "evil-sneak-"
  :group 'evil)

(defvar evil-sneak-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "s") 'evil-search-next)
    (define-key map (kbd "S") 'evil-search-previous)
    (define-key map [t] 'evil-sneak-exit)
    map))

(define-minor-mode evil-sneak-mode
  "Evil-sneak minor mode."
  :init-value nil
  :lighter " debug"
  :keymap evil-sneak-mode-map
  :group evil-sneak
  (evil-normalize-keymaps))

(evil-make-overriding-map evil-sneak-mode-map nil)

(defvar evil-sneak--evil-regexp-search-backup nil)

(evil-define-motion evil-sneak (count first second)
  "Jump to the position of a two-character string."
  :jump t
  :type exclusive
  (interactive "p\nc\nc")
  (evil-search (string first second) t nil)
  (setq evil-sneak--evil-regexp-search-backup evil-regexp-search
  evil-regexp-search nil
  isearch-forward 'forward)
  (evil-sneak-mode 1))

(defun evil-sneak-exit (&optional arg)
  (interactive "P")
  (evil-sneak-mode 0)
  (setq evil-regexp-search evil-sneak--evil-regexp-search-backup)
  (execute-kbd-macro (this-command-keys)))



(define-key evil-normal-state-map (kbd "s") 'evil-sneak)

(provide 'evil-sneak)
