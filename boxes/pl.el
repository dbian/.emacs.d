;; -*- lexical-binding: t; -*-
;; programing related settings

;;; eglot
(dolist (m '(mhtml-mode-hook racket-mode-hook python-mode-hook js-mode-hook css-mode-hook))
  (add-hook m 'eglot-ensure))
