(defgroup magit-magic nil
  "Some improvements for magit"
  :group 'magit)

(defun evil-git-add-current-file ()
  (interactive)
  (start-process "git-add"
                 (get-buffer-create "*git-add*")
                 "git" "add" buffer-file-name)
  (find-file-noselect buffer-file-name)
  (message "File added"))

(defun evil-git-checkout-current-file ()
  (interactive)
  (start-process "git-checkout"
                 (get-buffer-create "*git-checkout*")
                 "git" "checkout --" buffer-file-name)
  (find-file-noselect buffer-file-name))

(evil-leader/set-key "ga" 'evil-git-add-current-file)
(evil-ex-define-cmd "Gread" 'evil-git-checkout-current-file)
(evil-leader/set-key
  "gs" 'magit-status
  "gp" 'magit-push)

(provide 'magit-magic)
