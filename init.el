;; -*- lexical-binding: t; -*-

;;;; 原生设置，崩溃情况下也可用

(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

;; restart
(bind-key "C-c C-q" 'restart-emacs)
;;
(global-set-key (kbd "C-c d") 'duplicate-line)

;; dired prompt
(setq dired-deletion-confirmer #'y-or-n-p)

;; set emacs maximize on load
(toggle-frame-maximized)


(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")


(setq truncate-lines nil)

(recentf-mode 1)

;; disable the toolbar
;;(tool-bar-mode -1)

(require 'use-package)

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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completion-auto-help t)
 '(fido-mode t)
 '(fido-vertical-mode t)
 '(icomplete-mode t)
 '(package-selected-packages
   '(magit which-key v2ex-mode use-package paredit olivetti llama-cpp git-gutter company-box clojure-mode))
 '(recentf-exclude '(".*\\.gz" ".*\\.zip")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t ((\,@ headline) (\,@ variable-tuple) :height 2.0 :underline nil)))))


;; paredit
(require 'paredit)
;;(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code."
;;  t)

;; (mapc #'straight-use-package
;;       '(
;; 	;; git-gutter
	
	
;; 	;; exec-path-from-shell
;; 		olivetti ;; balance org mode
;; 	cider
;; 	))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

					;(load-theme 'gruvbox-light-hard t)
(require 'olivetti)
(add-hook 'text-mode-hook 'olivetti-mode)


;; org mode
(setq org-default-notes-file
      "/sshx:dd@beast:/home/dd/ws/dev-diary/inbox.org")


;; (add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; (add-hook 'prog-mode-hook #'hl-line-mode)
;; (add-hook 'prog-mode-hook #'show-paren-mode)
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

(require 'which-key)
(which-key-mode)

;; 解决windows远程的时候报错
;;(setq geiser-guile-binary "guile")





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

(require 'llama-cpp)
;; llama cpp server的集成
(use-package llama-cpp
  :ensure t
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


;; clojure
(require 'clojure-mode)
(use-package clojure-mode
  :ensure t
  )


;; git gutter
(global-git-gutter-mode +1)

;; tab
;;(tab-bar-mode t)


;; quick commit git
(bind-key "C-c g" 'git-quick-commit)



