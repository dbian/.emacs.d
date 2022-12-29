;; -*- lexical-binding: t; -*-
;;(set-language-environment 'UTF-8)
;;(set-locale-environment "UTF-8")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(leuven))
 '(package-selected-packages
   '(orderless vertico groovy-mode eglot company-box company magit which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

;; (require 'helm)
;; (global-set-key (kbd "C-h r")                        'helm-info-emacs)
;; (global-set-key (kbd "M-x")                          'undefined)
;; (global-set-key (kbd "M-x")                          'helm-M-x)
;; (global-set-key (kbd "M-y")                          'helm-show-kill-ring)
;; (global-set-key (kbd "C-x C-f")                      'helm-find-files)
;; (global-set-key (kbd "C-c <SPC>")                    'helm-mark-ring)
;; (global-set-key [remap bookmark-jump]                'helm-filtered-bookmarks)
;; (global-set-key (kbd "C-:")                          'helm-eval-expression-with-eldoc)
;; (global-set-key (kbd "C-,")                          'helm-calcul-expression)
;; (global-set-key (kbd "C-h d")                        'helm-info-at-point)
;; (global-set-key (kbd "C-h i")                        'helm-info)
;; (global-set-key (kbd "C-x C-d")                      'helm-browse-project)
;; (global-set-key (kbd "<f1>")                         'helm-resume)
;; (global-set-key (kbd "C-h C-f")                      'helm-apropos)
;; (global-set-key (kbd "C-h a")                        'helm-apropos)
;; (global-set-key (kbd "C-h C-d")                      'helm-debug-open-last-log)
;; (global-set-key (kbd "<f5> s")                       'helm-find)
;; (global-set-key (kbd "S-<f3>")                       'helm-execute-kmacro)
;; (global-set-key (kbd "C-c i")                        'helm-imenu-in-all-buffers)
;; (global-set-key (kbd "C-c C-i")                      'helm-imenu)
;; (global-set-key (kbd "<f11>")                        nil)
;; (global-set-key (kbd "<f11> o")                      'helm-org-agenda-files-headings)
;; (global-set-key (kbd "M-s")                          nil)
;; (global-set-key (kbd "M-s")                          'helm-occur-visible-buffers)
;; (global-set-key (kbd "<f6> h")                       'helm-emms)
;; (define-key global-map [remap jump-to-register]      'helm-register)
;; (define-key global-map [remap list-buffers]          'helm-mini)
;; (define-key global-map [remap dabbrev-expand]        'helm-dabbrev)
;; (define-key global-map [remap find-tag]              'helm-etags-select)
;; (define-key global-map [remap xref-find-definitions] 'helm-etags-select)
;; (define-key global-map (kbd "M-g a")                 'helm-do-grep-ag)
;; (define-key global-map (kbd "M-g l")                 'goto-line)
;; (define-key global-map (kbd "M-g g")                 'helm-grep-do-git-grep)
;; (define-key global-map (kbd "M-g M-g")               'helm-revert-next-error-last-buffer)
;; (define-key global-map (kbd "M-g i")                 'helm-gid)
;; (define-key global-map (kbd "C-x r p")               'helm-projects-history)
;; (define-key global-map (kbd "C-x r c")               'helm-addressbook-bookmarks)
;; (define-key global-map (kbd "C-c t r")               'helm-dictionary)

(which-key-mode)

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

;; (amx-mode t)
;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))
