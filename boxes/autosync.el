;; -*- lexical-binding: t; -*-

;;; 设定自动git同步的文件夹列表
(setq auto-git-sync-folder '(".emacs.d" "dev-diary"))

; 定时同步功能，通过钩子启动定时器，先实现手动同步功能
;; (defun git-sync-folder-once
;;     "git sync folder on current buffer's vc root"
  
;;     )

;;;;; -> backup

(define-minor-mode org-sync-mode
  "Git Auto Sync Mode."
  :init-value nil
  :lighter "GAS"
  :global nil
  :group 'OrgSync
  (if org-sync-mode
      (org-sync-start-timer)
    (org-sync-stop-timer)))

(defvar org-sync-timer nil
  "定时器对象.")

(defun org-sync-start-timer ()
  "启动定时器"
  (setq org-sync-timer
        (run-with-timer 0 30 #'org-sync-git-fetch-rebase)))

(defun org-sync-stop-timer ()
  "停止定时器"
  (when org-sync-timer
    (cancel-timer org-sync-timer)
    (setq org-sync-timer nil)))

(defun org-sync-git-fetch-rebase ()
  "执行 git fetch 和 git rebase 操作."
  (interactive)
  (message "GAS: git fetch...")
  (shell-command "git fetch")
  (let ((output (shell-command-to-string "git status --porcelain")))
    (if (string-empty-p output)
        (message "GAS： 本地已是最新状态，无需更新。")
      (progn
        (message "GAS: 远端有新的修改，合并更新...")
        (message "执行 git rebase...")
        (shell-command "git rebase origin/main --autostash")
        (git-quick-commit)))
    (message "GAS: 同步完成")
    ))

;; git commit current git directory, with optional one line message, default title is current timestamp
(defun git-quick-commit ()
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
