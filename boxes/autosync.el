;; -*- lexical-binding: t; -*-

;;; 设定自动git同步的文件夹列表
(setq auto-git-sync-folder '(".emacs.d" "dev-diary"))

; 定时同步功能，通过钩子启动定时器，先实现手动同步功能
;; (defun git-sync-folder-once
;;     "git sync folder on current buffer's vc root"
  
;;     )

;;;;; -> backup

(define-minor-mode org-sync-mode-gas
  "Git Auto Sync Mode."
  :init-value nil
  :lighter " GAS"
  :global nil
  :group 'OrgSync
  (if org-sync-mode
      (org-sync-start-timer)
    (org-sync-stop-timer)))


; sync .emacs.d once
(defun sync-emacs-d (sync-dir)
  (when (file-directory-p sync-dir)
    (message (format "syncing git for %s" sync-dir))
    (setq func (lambda ()
		 (org-sync-git-fetch-rebase sync-dir)))
    (run-with-timer 0 300
		    func)
    (add-hook 'kill-emacs-hook func)
    )
  )

(sync-emacs-d "~/.emacs.d")
(sync-emacs-d "~/ws/dev-diary")

(defmacro cd-sync-dir (arg)
  `(format "cd %s && %s" sync-dir ,arg))

(defun org-sync-git-fetch-rebase (sync-dir)
  "执行 git fetch 和 git rebase 操作."
  (interactive)
  (message "GAS: git fetch...")
  (shell-command (cd-sync-dir "git fetch"))
  (let ((output (shell-command-to-string (cd-sync-dir "git status --porcelain"))))
    (if (string-empty-p output)
        (progn
	  (message "GAS： 本地无修改，进行rebase操作")
	  (shell-command (cd-sync-dir "git pull --rebase")))
      (progn
        (message "GAS: 本地有新的修改，合并更新...")
        (message "GAS: 执行 git rebase...")
        (shell-command (cd-sync-dir "git pull --rebase --autostash"))
        (git-quick-commit-dir sync-dir)))
    (message (format "GAS: 同步完成 %s" sync-dir))
    ))

(defun git-quick-commit-dir (sync-dir)
  "git commit elpa submodules, with one line message, default title is current timestamp"
  (shell-command (cd-sync-dir "git add ."))
  (shell-command (cd-sync-dir (concat "git commit -m \"" (format-time-string "%Y-%m-%d %H:%M:%S" (current-time)) "\"")))
  (shell-command (cd-sync-dir "git push"))
  )

;; git commit current git directory, with optional one line message, default title is current timestamp
(defun git-quick-commit (args)
  "git commit elpa submodules, with one line message, default title is current timestamp"
  (interactive "P")
  (shell-command "git add .")
  (shell-command (concat "git commit -m \"" (format-time-string "%Y-%m-%d %H:%M:%S" (current-time)) "\""))
  (shell-command "git push")
  )

(defun git-quick-pull ()
  ""
  (interactive)
  (async-shell-command "git pull --autostash --rebase")
  )
