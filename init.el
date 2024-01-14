;; -*- lexical-binding: t; -*-

;;;; 原生设置，崩溃情况下也可用
(xterm-mouse-mode)
(setq inhibit-startup-screen 't)
;; 设置主题
;; (add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'load-path (expand-file-name "boxes" "~/.emacs.d"))

(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
; add vc keyword for use-package
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))

;; restart
(global-set-key (kbd "C-c C-q") 'restart-emacs)
;;
(global-set-key (kbd "C-c d") 'duplicate-line)

;; dired prompt
(setq dired-deletion-confirmer #'y-or-n-p)

;; set emacs maximize on load
;; (toggle-frame-maximized)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")


(setq truncate-lines nil)

(recentf-mode 1)

;; disable the toolbar

(require 'use-package)
(setq use-package-compute-statistics t)
(require 'use-package-ensure)

(use-package tabby-mode
  :vc (:fetcher github :repo dbian/tabby-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(completion-auto-help t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes '(wombat))
 '(fringe-mode 0 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(global-tab-line-mode t)
 '(indicate-empty-lines t)
 '(org-agenda-files '("~/ws/dev-diary"))
 '(org-capture-templates
   '(("t" "all kinds of todos" entry
      (file "~/ws/dev-diary/inbox.org")
      "* TODO %? :: Captured @ %T%^{Effort|2d}p" :prepend t :jump-to-captured t)
     ("c" "new comprehension on things" entry
      (file "~/ws/dev-diary/comprehension.org")
      "* %? :: added @ %T" :prepend t :jump-to-captured t)))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   '(sideline eldoc-box racket-mode expand-region pet company-box git-gutter llama-cpp magit olivetti paredit v2ex-mode which-key cider geiser-chibi ace-window vertico orderless marginalia dumb-jump valign company tabby-mode))
 '(package-vc-selected-packages
   '((vc-use-package :vc-backend Git :url "https://github.com/slotThe/vc-use-package")))
 '(recentf-exclude '(".*\\.gz" ".*\\.zip"))
 '(scroll-bar-mode nil)
 '(size-indication-mode t)
 '(tab-bar-history-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "outline" :slant normal :weight regular :height 98 :width normal)))))

;; load my custom seperate init files
(load  "completion")

(load "init-jump")
(load "init-funcs")


(use-package company
  :config (global-company-mode))

(use-package company-box
  :config (add-hook 'company-mode-hook 'company-box-mode))


(use-package ace-window
  :config
  (global-set-key (kbd "M-o") 'ace-window))

(use-package olivetti
  :config (add-hook 'text-mode-hook 'olivetti-mode))

;; # better programing

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; lsp setup
(use-package eglot
  :ensure t
  :defer t
  :hook (python-mode . eglot-ensure))

(add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-at-point-mode t)
;; (use-package lsp-mode
;;   :ensure t
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (python-mode . lsp)
;;          ;; if you want which-key integration
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp)

;; optionally
;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode)

(use-package pet
  :ensure t
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10))

; racket
(use-package racket-mode
  :ensure t
  )

(use-package eldoc-box
  :ensure t
  ;; :config
  ;; (eldoc-box-hover-mode)
  )

;; (use-package sideline
;;   :ensure t
;;   :init
;;   (setq sideline-backends-left-skip-current-line t   ; don't display on current line (left)
;;         sideline-backends-right-skip-current-line t  ; don't display on current line (right)
;;         sideline-order-left 'down                    ; or 'up
;;         sideline-order-right 'up                     ; or 'down
;;         sideline-format-left "%s   "                 ; format for left aligment
;;         sideline-format-right "   %s"                ; format for right aligment
;;         sideline-priority 100                        ; overlays' priority
;;         sideline-display-backend-name t)
;;   :hook ((flycheck-mode . sideline-mode)   ; for `sideline-flycheck`
;; 	 (flymake-mode  . sideline-mode))  ; for `sideline-flymake`
;;   )            ; display the backend name

;; (add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; (add-hook 'prog-mode-hook #'hl-line-mode)

;; (mapc (lambda (mode)
;; 	(add-hook 'prog-mode-hook mode))
;;       '(rainbow-delimiters-mode
;; 	show-paren-mode
;; 	company-mode
;; 	))

;; (add-hook 'scheme-mode-hook  #'geiser-mode)

;; (mapc (lambda (mode)
;; 	(add-hook mode 'company-mode))
;;       '(prog-mode-hook
;; 	conf-mode-hook
;; 	text-mode-hook
;; 	org-mode-hook))
;; (mapc (lambda (mode)
;; 	(add-hook mode 'paredit-mode))
;;       '(prog-mode-hook
;; 	conf-mode-hook
;; 	emacslisp-mode-hook
;; 	lisp-mode-hook
;; 	scheme-mode-hook
;; 	))

;; (when (memq window-system '(mac ns x))
;;   (exec-path-from-shell-initialize))

(use-package which-key
  :config
  (which-key-mode))

(use-package magit)

;; 解决windows远程的时候报错
;;(setq geiser-guile-binary "guile")

(use-package paredit
  :config
  (autoload 'enable-paredit-mode "paredit"
    "Turn on pseudo-structural editing of Lisp code."
    t)
  (add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           'enable-paredit-mode))


;; 在当前鼠标位置插入今天的日期,格式为:2012-12-12
(defun insert-current-date (arg)
  "Insert the current date. With prefix ARG, insert the date and time."
  (interactive "P")
  (insert (format-time-string "%Y-%m-%d" (current-time)))
  )

;; current timestamp
(defun insert-current-timestamp (arg)
  "Insert the current timestamp. With prefix ARG, insert the date and time."
  (interactive "P")
  (insert (format-time-string "%Y-%m-%d %H:%M:%S" (current-time)))
  )

;; git commit current git directory, with optional one line message, default title is current timestamp
(defun git-quick-commit (arg)
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

;; llama cpp server的集成
(use-package llama-cpp
  :ensure t
  :init
  (setq llama-cpp-host "192.168.31.67")
  (setq llama-cpp-port 58870)
  ;; mixtral
  (setq llama-cpp-chat-prompt "")
  (setq llama-cpp-chat-prompt-prefix "<s> ")
  (setq llama-cpp-chat-input-prefix "[INST] ")
  (setq llama-cpp-chat-input-suffix " [/INST]")

  ;; zephyr
;;   (setq llama-cpp-chat-input-prefix "<|user|>
;; ")
;;   (setq llama-cpp-chat-input-suffix "</s>
;; <|assistant|>
;; ")

;;   (setq llama-cpp-chat-prompt "<|system|>
;; </s>
;; "
;; )
  :config
  (bind-key "C-c s" 'llama-cpp-chat-start)
  (bind-key "C-c C-s" 'llama-cpp-cancel)
  (bind-key "C-c RET" 'llama-cpp-chat-answer)
  (bind-key "C-c t" 'llama-cpp-code-region-task)
  )

; tabby
(use-package tabby-mode
  :init
  (setq tabby-api-url "http://192.168.31.67:58880")
  (add-hook 'prog-mode-hook #'tabby-mode)
  )


;; (bind-key "C-c k" 'tabby-complete)


;; clojure
;; (use-package clojure-mode
;;   :ensure t
;;   )

;; (use-package cider
;;   :ensure t)

;; git gutter
(use-package git-gutter
  :config
  (global-git-gutter-mode +1))

;; tab
;;(tab-bar-mode t)


;; quick commit git
(bind-key "C-c C-d" 'git-quick-commit)
(bind-key "C-c C-p" 'git-quick-pull)


;; org mode
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c b") #'org-switchb)
(global-set-key (kbd "<f12>") #'eshell)
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
(setq org-directory "~/ws/dev-diary")


(define-minor-mode org-sync-mode
  "Org Sync Mode"
  :init-value nil
  :lighter " OrgSync"
  :global nil
  :group 'OrgSync
  (if org-sync-mode
      (org-sync-start-timer)
    (org-sync-stop-timer)))

(defvar org-sync-timer nil
  "定时器对象")

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
  "执行 git fetch 和 git rebase 操作"
  (message "执行 git fetch...")
  (shell-command "git fetch")
  (let ((output (shell-command-to-string "git status --porcelain")))
    (if (string-empty-p output)
        (message "本地已是最新状态，无需更新。")
      (progn
        (message "远端有新的修改，请合并更新。")
        (message "执行 git rebase...")
        (shell-command "git rebase origin/main --autostash")
        (let ((local-modified (shell-command-to-string "git status --porcelain")))
          (when (not (string-empty-p local-modified))
            (message "本地有未提交的修改，请先提交或保存！")
            (message "提示：执行 `git-auto-commit` 函数可以自动提交修改。")
            (org-sync-git-auto-commit)))))))

(defun org-sync-git-auto-commit ()
  "执行 git-auto-commit 函数"
  (message "执行 git-auto-commit...")
  ;; 在这里调用 `git-auto-commit` 函数的外部实现
  (git-quick-commit)
  )

;;(add-hook 'org-mode-hook #'org-sync-mode)

;; scheme
(use-package geiser-chibi)
