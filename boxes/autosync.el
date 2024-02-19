;; -*- lexical-binding: t; -*-


(defmacro gas-log (m &optional desktop)
  `(let ((msg (format "GAS[%s][%s]: %s" sync-dir (current-time-string) ,m)))
    (if ,desktop
	(alert-toast-notify `(:title "自动同步系统" :message ,msg :data (:long t)))
	(message msg)))
  )
					; sync .emacs.d once
(defun auto-sync-git-dir (sync-dir start-sec)
  "自动同步git目录，周期性同步，退出前同步
on-exit-no-fetch: 退出时仅检查本地有无提交
"
  (when (file-directory-p sync-dir)
    (gas-log "syncing")
					; every 30m backup
    (run-with-timer start-sec 1800
		    (lambda () (org-sync-git-fetch-rebase sync-dir t nil)))
    (add-hook 'kill-emacs-hook (lambda () (org-sync-git-fetch-rebase sync-dir nil t)))
    )
  )

(defmacro if-win-or-else (win-op other-op)
	  `(if
	    (eq system-type 'windows-nt) ,win-op
	    ,other-op))



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
     (message (shell-command-to-string (format "%s %s %s %s" system-shell-cd-oper sync-dir system-shell-and-oper ,arg)))))


(defun org-sync-git-fetch-rebase (sync-dir async on-exit-no-fetch)
  "执行 git fetch 和 git rebase 操作."
  (interactive)
  ;; (message (format "GAS: git fetch... %s" sync-dir))
  ;; (when (not on-exit-no-fetch)
  ;;   (exe-sh-in-dir "git fetch"))
  (let ((output (exe-sh-in-dir "git status --porcelain")))
    (if (string-empty-p output)
        (if on-exit-no-fetch
	    (gas-log "exit directly")
	  (progn
	    (gas-log "本地无修改，进行rebase操作")
	    (exe-sh-in-dir "git pull --rebase")))
      (progn
        (gas-log "本地有新的修改，合并更新...")
        (gas-log "执行 git rebase...")
        (exe-sh-in-dir "git pull --rebase --autostash")
        (git-quick-commit-dir sync-dir)
	(gas-log "同步完成" t)))
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

(auto-sync-git-dir (if-win-or-else
	       "c:/Users/hdbian/AppData/Roaming/.emacs.d"
	       "~/.emacs.d")
	      0)
(auto-sync-git-dir (if-win-or-else
	       "D:/dev-diary"
	       "~/ws/dev-diary")
	      30)

;; mode line status

(defun calculate-modeline-status ()
  ;; 将进度同步的倒计时显示到modeline上，怎么显示。可以显示两个倒计时，每个都显示即将更新的分钟数(Cfg 23, Diary 21)，每分钟刷新一次
  
  )

(add-to-list 'global-mode-string '(" " (:eval (calculate-modeline-status))) " ")

