;; set default font
(cond
 ((eq system-type 'windows-nt)
  (when (member "Consolas" (font-family-list))
    (set-frame-font "Consolas" t t)))
 ((eq system-type 'darwin) ; macOS
  (when (member "Menlo" (font-family-list))
    (set-frame-font "Menlo" t t)))
 ((eq system-type 'gnu/linux)
  (when (member "DejaVu Sans Mono" (font-family-list))
    (set-frame-font "DejaVu Sans Mono-10" t t))))

(set-fontset-font
 t
 'symbol
 (cond
  ((eq system-type 'windows-nt)
   (cond
    ((member "Segoe UI Symbol" (font-family-list)) "Segoe UI Symbol")))
  ((eq system-type 'darwin)
   (cond
    ((member "Apple Symbols" (font-family-list)) "Apple Symbols")
    ))
  ((eq system-type 'gnu/linux)
   (cond
    ((member "Symbola" (font-family-list)) "Symbola")))))

;; set font for chinese中文字体
(set-fontset-font
 t
 'han
 (cond
  ((eq system-type 'windows-nt)
   (cond
    ((member "Microsoft YaHei" (font-family-list)) "Microsoft YaHei")
    ((member "Microsoft JhengHei" (font-family-list)) "Microsoft JhengHei")
    ((member "SimHei" (font-family-list)) "SimHei")))
  ((eq system-type 'darwin)
   (cond
    ((member "Hei" (font-family-list)) "Hei")
    ((member "Heiti SC" (font-family-list)) "Heiti SC")
    ((member "Heiti TC" (font-family-list)) "Heiti TC")))
  ((eq system-type 'gnu/linux)
   (cond
    ((member "WenQuanYi Micro Hei" (font-family-list)) "WenQuanYi Micro Hei")
    ((member "Noto Sans CJK SC" (font-family-list)) "Noto Sans CJK SC-10")))))

;; (set-face-attribute 'org-table nil :family "M+ 1m" :height 100 :weight 'normal)

(use-package valign
  :config
  (add-hook 'org-mode-hook #'valign-mode))
