;; -*- lexical-binding: t; -*-

;;;; 原生设置，崩溃情况下也可用
(xterm-mouse-mode)
(setq inhibit-startup-screen 't)
;; 设置主题
;; (add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'load-path (expand-file-name "boxes" "~/.emacs.d"))

(setq package-archives '(("jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/")
			 ("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(setq package-archive-priorities '(("melpa"    . 5)
				   ("gnu"    . 5)
				   ("nongnu"    . 5)
                                   ("jcs-elpa" . 0)))
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

;; (use-package nyan-mode
;;   :config
;;   (nyan-mode 1))

;; disable the toolbar

(require 'use-package)
(setq use-package-compute-statistics t)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

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
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   '("efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" default))
 '(fringe-mode 0 nil (fringe))
 '(global-auto-revert-mode t)
 '(global-display-line-numbers-mode t)
 '(global-tab-line-mode t)
 '(indicate-empty-lines t)
 '(org-confirm-babel-evaluate nil)
 '(org-display-remote-inline-images 'cache)
 '(org-hide-leading-stars t)
 '(package-selected-packages
   '(all-the-icons-nerd-fonts nerd-icons-completion nerd-icons-dired doom-modeline jupyter burly burly.el hackernews org-modern org-download embark-consult embark consult gnuplot solarized-theme graphviz-dot-mode d2-mode rg exec-path-from-shell python-isort python-black python-pytest dired-sidebar elsa flymake-elsa lsp-pyright lsp-ui lsp-mode sideline-eldoc sideline eldoc-box racket-mode expand-region pet company-box git-gutter llama-cpp magit olivetti paredit v2ex-mode which-key cider geiser-chibi ace-window vertico orderless marginalia dumb-jump valign company tabby-mode))
 '(package-vc-selected-packages
   '((burly.el :vc-backend Git :url "https://github.com/alphapapa/burly.el.git")
     (sideline-eldoc :vc-backend Git :url "https://github.com/ginqi7/sideline-eldoc")
     (vc-use-package :vc-backend Git :url "https://github.com/slotThe/vc-use-package")))
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
 )

;; load my custom seperate init files
(load  "completion")

(load "init-jump")
(load "init-funcs")
(load "init-font")
(load "autosync")
(load "init-org")

(use-package burly)

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

;; search
(use-package rg
  :config
  (rg-enable-default-bindings)
  )


;; lsp setup
;; (use-package eglot
;;   :ensure t
;;   :defer t
;;   :hook (python-mode . eglot-ensure))
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         (racket-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (use-package lsp-pyright
    :ensure t
    :hook (python-mode . (lambda ()
                           (require 'lsp-pyright)
                           (lsp))))	; or lsp-deferred
  :commands lsp)

;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

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

; python
(use-package exec-path-from-shell
  :ensure t
  :if (memq (window-system) '(mac ns))
  :config (exec-path-from-shell-initialize))
(use-package python-pytest :ensure t)

(use-package python-black :ensure t
  :demand t
  :after python
  )

(use-package python-isort :ensure t)
(use-package pet
  :ensure t
  :config
  (add-hook 'python-base-mode-hook
	    (lambda ()
	      (pet-mode)
	      (setq-local python-shell-interpreter (pet-executable-find "python")
			  python-shell-virtualenv-root (pet-virtualenv-root))

	      ;; (pet-eglot-setup)
	      ;; (eglot-ensure)

					;(pet-flycheck-setup)
					;(flycheck-mode)

	      ;; (setq-local lsp-jedi-executable-command
	      ;;             (pet-executable-find "jedi-language-server"))

	      (setq-local lsp-pyright-python-executable-cmd python-shell-interpreter
			  lsp-pyright-venv-path python-shell-virtualenv-root)

	      (lsp)

	      (setq-local dap-python-executable python-shell-interpreter)

	      (setq-local python-pytest-executable (pet-executable-find "pytest"))

	      (when-let ((black-executable (pet-executable-find "black")))
		(setq-local python-black-command black-executable)
		(python-black-on-save-mode))

	      (when-let ((isort-executable (pet-executable-find "isort")))
		(setq-local python-isort-command isort-executable)
		(python-isort-on-save-mode))))
  )

; racket
(use-package racket-mode
  :ensure t
  )

; d2 mode
(use-package d2-mode)

(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4)
  (setq graphviz-dot-preview-extension "svg")
  )


					; elisp
;; (use-package elsa
;;   :ensure t
;;   :config
;;   (progn
;;     (elsa-lsp-register)
;;     (add-hook 'emacs-lisp-mode-hook #'lsp)
;;     )
;;   )

(use-package flymake-elsa
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'flymake-elsa-load)
  )

(if (display-graphic-p)
    (use-package eldoc-box
      :ensure t
      :config
      (add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-at-point-mode t)
      )
  (progn
    (message "terminal mode will fallback eldoc ui to original")
    ;; (use-package sideline
    ;;   :ensure t
    ;;   :init
    ;;   (setq sideline-backends-left-skip-current-line t ; don't display on current line (left)
    ;;         sideline-backends-right-skip-current-line t ; don't display on current line (right)
    ;;         sideline-order-left 'down			; or 'up
    ;;         sideline-order-right 'up			; or 'down
    ;;         sideline-format-left "%s   " ; format for left aligment
    ;;         sideline-format-right "   %s" ; format for right aligment
    ;;         sideline-priority 100	  ; overlays' priority
    ;;         sideline-display-backend-name t)
    ;;   :hook (				     ; for `sideline-flycheck`
    ;; 	     (flymake-mode  . sideline-mode)) ; for `sideline-flymake`
    ;;   )
    ;; (use-package sideline-eldoc
    ;;   :vc (:fetcher github :repo ginqi7/sideline-eldoc)
    ;;   :config
    ;;   (add-hook 'eglot-managed-mode-hook #'sideline-mode t)
    ;;   )   
    ;; )            ; display the backend name
    )
  )




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

; side tree
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  ;; (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'nerd)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

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


;; ;; quick commit git
;; (bind-key "C-c C-d" 'git-quick-commit)
;; (bind-key "C-c C-p" 'git-quick-pull)







;;(add-hook 'org-mode-hook #'org-sync-mode)

;; scheme
;; (use-package geiser-chibi)


(defun replace-pair-of-brackets ()
  "替换选中的括号对为另一种类型的括号对."
  (interactive)
  (let* ((start-pos (region-beginning))
         (end-pos (region-end))
         (original-text (buffer-substring start-pos end-pos))
         (left-bracket (read-char "请输入另一种括号的左类型: "))
         (right-bracket (cdr (assoc left-bracket '((?\( . ?\))
                                                   (?\[ . ?\])
                                                   (?\{ . ?\})))))
	 (new-text (concat (char-to-string left-bracket)
                      (substring original-text 1 (- (length original-text) 1))
                      (char-to-string right-bracket)))
	 ) ; 可以根据需要添加其他括号类型的映射

    (delete-region start-pos end-pos)
    (insert new-text)))

;; Restore Opened Files
;;desktop-globals-to-save (desktop-missing-file-warning tags-file-name tags-table-list search-ring regexp-search-ring register-alist file-name-history)
;; (progn
;;   (desktop-save-mode 1)
;;   (setq desktop-globals-to-save '(register-alist))
  ;;   ;; save when quit
  ;; (setq desktop-save t)

  ;;   ;; no ask if crashed
  ;;   (setq desktop-load-locked-desktop t)

  ;;   (setq desktop-restore-frames nil)

  ;;   (setq desktop-auto-save-timeout 300)
  ;;   (setq desktop-buffers-not-to-save
  ;;        (concat "\\("
  ;;                "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
  ;;                "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
  ;; 	       "\\|*scratch*"
  ;;                "\\)$"))
  ;;   (add-to-list 'desktop-modes-not-to-save 'dired-mode)
  ;;   (add-to-list 'desktop-modes-not-to-save 'Info-mode)
  ;;   (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
  ;;   (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)
  ;;   ;; save some global vars
  ;; (add-to-list 'desktop-globals-to-save 'register-alist)
  ;;   ;; 2023-09-16 default
  ;;   ;; '(desktop-missing-file-warning tags-file-name tags-table-list search-ring regexp-search-ring register-alist file-name-history)
  ;; )

(when (eq window-system 'w32)
  (setq tramp-default-method "plink")
  )

;; modeline beauty
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
(setq doom-modeline-icon nil)
