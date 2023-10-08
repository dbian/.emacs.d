;; -*- lexical-binding: t; -*-

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)


					; 设置中文字体，思源，等宽
					; 英文字体Source code pro ，等宽

(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  
  (set-fontset-font "fontset-default" 'han "思源黑体 Normal")
  (set-face-attribute 'default nil :font (font-spec :family "Source Code Pro" :size 14)
		      (setq onedrive-dir "D:/OneDrive/"))

  ;; 设置org mode 正文默认字号
  

  
  )

 ((string-equal system-type "darwin")	; macOS
  ()
					;  (when (member "Menlo" (font-family-list))
					;   (set-frame-font "Menlo" t t)))
  )
 ((string-equal system-type "gnu/linux") ; linux
  (when (member "DejaVu Sans Mono" (font-family-list))
    (set-frame-font "DejaVu Sans Mono" t t))))



(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(codeium/metadata/api_key "a832f556-8d9b-48c3-868d-262d1e524c48")
 '(completion-auto-help t)
 '(fido-mode t)
 '(fido-vertical-mode t)
 '(icomplete-mode t)
 '(package-selected-packages
   '(paredit geiser-guile geiser orderless vertico groovy-mode eglot company-box company magit which-key))
 '(recentf-exclude '(".*\\.gz" ".*\\.zip")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t ((\,@ headline) (\,@ variable-tuple) :height 2.0 :underline nil)))))

(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))


(mapc #'straight-use-package
      '(company
	geiser-guile
	geiser
	eglot
	groovy-mode

	git-gutter
	
	which-key
	company-box
	rainbow-delimiters
	orderless
	exec-path-from-shell
	magit
	;; helm
	paredit
	geiser-guile
	gruvbox-theme
	olivetti ;; balance org mode
	cider
	))

(add-hook 'after-init-hook 'global-company-mode)

					;(load-theme 'gruvbox-light-hard t)
(load-theme 'leuven t)
(add-hook 'text-mode-hook 'olivetti-mode)


;; org mode
(setq org-default-notes-file
      "/sshx:dd@beast:/home/dd/ws/dev-diary/inbox.org")


(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'prog-mode-hook #'show-paren-mode)
(mapc (lambda (mode)
	(add-hook 'prog-mode-hook mode))
      '(rainbow-delimiters-mode
	show-paren-mode
	company-mode
	))

(add-hook 'scheme-mode-hook  #'geiser-mode)

(mapc (lambda (mode)
	(add-hook mode 'company-mode))
      '(prog-mode-hook
	conf-mode-hook
	text-mode-hook
	org-mode-hook))
(mapc (lambda (mode)
	(add-hook mode 'paredit-mode))
      '(prog-mode-hook
	conf-mode-hook
	emacslisp-mode-hook
	lisp-mode-hook
	scheme-mode-hook
	))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(which-key-mode)

;; 解决windows远程的时候报错
;;(setq geiser-guile-binary "guile")


(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(setq truncate-lines nil)

(recentf-mode 1)

;; disable the toolbar
(tool-bar-mode -1)


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


;; llama cpp server的集成
(use-package llama-cpp
  :ensure t
  :straight t
  :init
  (setq llama-cpp-host "beast")
  (setq llama-cpp-port 58870)
  (setq llama-cpp-chat-input-prefix "<s>[INST] ")
  (setq llama-cpp-chat-input-suffix " [/INST]")
  (setq llama-cpp-chat-prompt "")
  (bind-key "C-c s" 'llama-cpp-chat-start)
  (bind-key "C-c c" 'llama-cpp-cancel)
  (bind-key "C-c RET" 'llama-cpp-chat-answer)
  (bind-key "C-c t" 'llama-cpp-code-region-task)
)


;; set emacs maximize on load
(toggle-frame-maximized)

;; clojure

(use-package clojure-mode
  :ensure t
  :straight t)


;; git gutter
(global-git-gutter-mode +1)

;; tab
;;(tab-bar-mode t)

;; restart
(bind-key "C-c C-q" 'restart-emacs)

;; quick commit git
(bind-key "C-c g" 'git-quick-commit)
;;
(global-set-key (kbd "C-c d") 'duplicate-line)

;; dired prompt
(setq dired-deletion-confirmer #'y-or-n-p)
