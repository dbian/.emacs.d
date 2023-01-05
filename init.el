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
(require 'recentf)
(setq recentf-auto-cleanup 'never)
(setq recentf-keep '(file-remote-p file-readable-p))
(defvar onedrive-dir "~/OneDrive/")
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
 ;'(custom-enabled-themes '(leuven))
 '(package-selected-packages
   '(paredit geiser-guile geiser orderless vertico groovy-mode eglot company-box company magit which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; (package-initialize) ;; You might already have this line


(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t)
(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))
(add-hook 'prog-mode-hook 'copilot-mode 'company-mode)
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
(setq copilot-log-max nil)

(mapc #'straight-use-package
      '(geiser-guile
	geiser
		     eglot
		     groovy-mode
		     company
		     which-key
		     company-box
		     rainbow-delimiters
		     orderless
		     exec-path-from-shell
		     magit
		     helm
		     paredit
		     dashboard
		     geiser-guile
		     gruvbox-theme
		     olivetti
		     deft
		     
))
;(load-theme 'gruvbox-light-hard t)
(load-theme 'leuven t)
(add-hook 'text-mode-hook 'olivetti-mode)

(use-package deft
					;  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory  (concat onedrive-dir "notes")
                deft-extensions '("org" "md" "txt")
                deft-default-extension "org"
		deft-recursive t))


		;; Or if you use use-package
		(use-package dashboard
		  :ensure t
		  :config
		  (dashboard-setup-startup-hook))

(setq dashboard-projects-backend 'project-el)
(setq dashboard-items '((recents  . 10)
                        (projects . 15)
                        (bookmarks . 5)
                        (agenda . 5)
                        (registers . 5)))
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'prog-mode-hook #'show-paren-mode)
(mapc (lambda (mode)
	(add-hook 'prog-mode-hook mode))
      '(rainbow-delimiters-mode
	show-paren-mode
	company-mode
	))
;(add-hook 'scheme-mode-hook 'geiser-guile )
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
(setq geiser-guile-binary "guile")

(defun duplicate-line (&optional arg)
  "Duplicate it. With prefix ARG, duplicate ARG times."
  (interactive "p")
  (next-line 
   (save-excursion 
     (let ((beg (line-beginning-position))
           (end (line-end-position)))
       (copy-region-as-kill beg end)
       (dotimes (num arg arg)
         (end-of-line) (newline)
         (yank))))))

(global-set-key (kbd "C-S-d") 'duplicate-line)

(require 'helm)
(global-set-key (kbd "C-h r")                        'helm-info-emacs)
(global-set-key (kbd "M-x")                          'undefined)
(global-set-key (kbd "M-x")                          'helm-M-x)
(global-set-key (kbd "M-y")                          'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f")                      'helm-find-files)
(global-set-key (kbd "C-c <SPC>")                    'helm-mark-ring)
(global-set-key [remap bookmark-jump]                'helm-filtered-bookmarks)
(global-set-key (kbd "C-:")                          'helm-eval-expression-with-eldoc)
(global-set-key (kbd "C-,")                          'helm-calcul-expression)
(global-set-key (kbd "C-h d")                        'helm-info-at-point)
(global-set-key (kbd "C-h i")                        'helm-info)
(global-set-key (kbd "C-x C-d")                      'helm-browse-project)
(global-set-key (kbd "<f1>")                         'helm-resume)
(global-set-key (kbd "C-h C-f")                      'helm-apropos)
(global-set-key (kbd "C-h a")                        'helm-apropos)
(global-set-key (kbd "C-h C-d")                      'helm-debug-open-last-log)
(global-set-key (kbd "<f5> s")                       'helm-find)
(global-set-key (kbd "S-<f3>")                       'helm-execute-kmacro)
(global-set-key (kbd "C-c i")                        'helm-imenu-in-all-buffers)
(global-set-key (kbd "C-c C-i")                      'helm-imenu)
(global-set-key (kbd "<f11>")                        nil)
(global-set-key (kbd "<f11> o")                      'helm-org-agenda-files-headings)
(global-set-key (kbd "M-s")                          nil)
(global-set-key (kbd "M-s")                          'helm-occur-visible-buffers)
(global-set-key (kbd "<f6> h")                       'helm-emms)
(define-key global-map [remap jump-to-register]      'helm-register)
(define-key global-map [remap list-buffers]          'helm-mini)
(define-key global-map [remap dabbrev-expand]        'helm-dabbrev)
(define-key global-map [remap find-tag]              'helm-etags-select)
(define-key global-map [remap xref-find-definitions] 'helm-etags-select)
(define-key global-map (kbd "M-g a")                 'helm-do-grep-ag)
(define-key global-map (kbd "M-g l")                 'goto-line)
(define-key global-map (kbd "M-g g")                 'helm-grep-do-git-grep)
(define-key global-map (kbd "M-g M-g")               'helm-revert-next-error-last-buffer)
(define-key global-map (kbd "M-g i")                 'helm-gid)
(define-key global-map (kbd "C-x r p")               'helm-projects-history)
(define-key global-map (kbd "C-x r c")               'helm-addressbook-bookmarks)
(define-key global-map (kbd "C-c t r")               'helm-dictionary)

(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(setq truncate-lines nil)

;; (require 'ido)
;; (ido-mode t)
;;     (global-set-key
;;      "\M-x"
;;      (lambda ()
;;        (interactive)
;;        (call-interactively
;;         (intern
;;          (ido-completing-read
;;           "M-x "
;;           (all-completions "" obarray 'commandp))))))



(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'helm-recentf)
;(put 'upcase-region 'disabled nil)


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

;; git commit elpa submodules, with one line message, default title is current timestamp
(defun git-commit-elpa-submodules (arg)
  "git commit elpa submodules, with one line message, default title is current timestamp"
  (interactive "P")
  (let ((default-directory "~/.emacs.d/elpa/"))
    (shell-command "git add .")
    (shell-command (concat "git commit -m \"" (format-time-string "%Y-%m-%d %H:%M:%S" (current-time)) "\""))
    (shell-command "git push")
    )
  )

(custom-set-faces
; '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 ;; '(org-block-begin-line ((t (:extend t :background "#f7e0c3" :foreground "gray"
                             ;; :weight semi-bold :height 151 :family "CMU Typewriter Text"))))
; '(org-code ((t (:foreground "#957f5f" :family "mononoki"))))
; '(org-document-title ((t (:foreground "midnight blue" :weight bold :height 2.0))))
; '(org-hide ((t (:foreground "#E5E9F0" :height 0.1))))

; '(org-list-dt ((t (:foreground "#7382a0"))))
 ;;'(org-verbatim ((t (:foreground "#81895d" :family "Latin Modern Mono"))))
; '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
; '(org-block ((t (:inherit fixed-pitch))))
; '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 ;; TODO set the color following this
 ;;'(org-block ((t (:extend t :background "#f7e0c3" :foreground "#5b5143" :family "Latin Modern Mono"))))
 ;;'(org-code ((t (:inherit (shadow fixed-pitch)))))
 ;; '(variable-pitch ((t (:family "DejaVu Serif" :height 150))))
 ;; '(fixed-pitch ((t (:family "mononoki" :height 160))))
 ;;'(org-level-8 ((t (,@headline ,@variable-tuple))))
 ;;'(org-level-7 ((t (,@headline ,@variable-tuple))))
 ;;'(org-level-6 ((t (,@headline ,@variable-tuple))))
 ;; '(org-level-5 ((t (:inherit outline-5 :height 1.05 :family "DejaVu Serif Condensed"))))
  ;; '(org-level-4 ((t (:inherit outline-4 :height 1.1 :family "CMU Typewriter Text"))))
 ;; '(org-level-3 ((t (:inherit outline-3 :height 1.25 :family "DejaVu Serif Condensed"))))
 ;; '(org-level-2 ((t (:inherit outline-2 :foreground "#EEC591" :height 1.5 :family
                    ;; "DejaVu Serif Condensed"))))
 ;; '(org-level-1 ((t (:inherit outline-1 :foreground "#076678" :weight extra-bold
                    ;; :height 1.75 :family "Alegreya"))))

 '(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil)))))

; tramp 远程编辑plink:dd@ed:~/ws/
(require 'tramp)
(setq tramp-default-method "plink")
(setq tramp-default-user "dd")
(setq tramp-default-host "ed")
(setq tramp-default-port "22")
(defun tramp-remote-edit ()
  (interactive)
  (let ((file-name "dd@ed:~/ws/"))
    (if (not (tramp-tramp-file-p file-name))
	(message "Not a tramp file.")
      (let ((vec (tramp-dissect-file-name file-name)))
	(find-file (tramp-make-tramp-file-name
		    (tramp-file-name-method vec)
		    (tramp-file-name-user vec)
		    (tramp-file-name-host vec)
		    (tramp-file-name-localname vec)))))))
(setq directory-abbrev-alist '(("^/waiter" . "/-:dd@ed:~/ws/waiter")))
