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

;; (set-face-attribute 'default nil :height 110)

(defun max/set-font (FONT-NAME CN-FONT-NAME &optional INITIAL-SIZE CN-FONT-RESCALE-RATIO)
  "Set different font-family for Latin and Chinese charactors."
  (let* ((size (or INITIAL-SIZE 14))
	 (ratio (or CN-FONT-RESCALE-RATIO 0.0))
	 (main (font-spec :name FONT-NAME :size size))
	 (cn (font-spec :name CN-FONT-NAME)))
    (set-face-attribute 'default nil :font main)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font t charset cn))
    (setq face-font-rescale-alist (if (/= ratio 0.0) `((,CN-FONT-NAME . ,ratio)) nil))))

;; 你好，世界
;; abcdefgh
(max/set-font "JetBrains Mono" "Microsoft YaHei" 14 1.5)

