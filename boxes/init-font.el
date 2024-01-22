;; set for unicode

(cond
 ((member "JetBrains Mono" (font-family-list)) (progn
						 (message "set ascii font")
						 (set-frame-font "JetBrains Mono")
						 )))
;; set font for chinese
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
    ((member "WenQuanYi Micro Hei" (font-family-list)) "WenQuanYi Micro Hei")))))

(set-face-attribute 'default nil :height 110)
