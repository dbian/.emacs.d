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
    ; every 30m backup
    (run-with-timer 0 1800
		    func)
    (add-hook 'kill-emacs-hook func)
    )
  )

(defmacro if-win-or-else (win-op other-op)
	  `(if
	    (eq system-type 'windows-nt) ,win-op
	    ,other-op))

(sync-emacs-d (if-win-or-else
	       "c:/Users/hdbian/AppData/Roaming/.emacs.d"
	       "~/.emacs.d"))
(sync-emacs-d (if-win-or-else
	       "D:/dev-diary"
	       "~/ws/dev-diary"))

(defvar system-out-encoding  (if-win-or-else
	       'gbk
	       'utf-8))

(defvar system-shell-and-oper  (if-win-or-else
	       "&"
	       "&&"))

(defvar system-shell-cd-oper  (if-win-or-else
				"cd /d"
				"cd"))
(defmacro exe-sh-in-dir (arg)
  `(let ((coding-system-for-read system-out-encoding))
     (shell-command-to-string (format "%s %s %s %s" system-shell-cd-oper sync-dir system-shell-and-oper ,arg))))

(defun org-sync-git-fetch-rebase (sync-dir)
  "执行 git fetch 和 git rebase 操作."
  (interactive)
  (message "GAS: git fetch...")
  (exe-sh-in-dir "git fetch")
  (let ((output (exe-sh-in-dir "git status --porcelain")))
    (if (string-empty-p output)
        (progn
	  (message "GAS： 本地无修改，进行rebase操作")
	  (exe-sh-in-dir "git pull --rebase"))
      (progn
        (message "GAS: 本地有新的修改，合并更新...")
        (message "GAS: 执行 git rebase...")
        (exe-sh-in-dir "git pull --rebase --autostash")
        (git-quick-commit-dir sync-dir)))
    (message (format "GAS: 同步完成 %s" sync-dir))
    ))

(defun git-quick-commit-dir (sync-dir)
  "git commit elpa submodules, with one line message, default title is current timestamp"
  (exe-sh-in-dir "git add .")
  (exe-sh-in-dir (concat "git commit -m \"" (format-time-string "%Y-%m-%d %H:%M:%S" (current-time)) "\""))
  (exe-sh-in-dir "git push")
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
