;; -*- lexical-binding: t; -*-

;; set for en
(let* ((prefered-ordered-ch-font-list '("JetBrains Mono" "Menlo" "Consolas"))
       (font-list (font-family-list))
       (font-en (seq-find (lambda (f) (member f font-list)) prefered-ordered-ch-font-list)))
  (message (format "set ascii font to %s" font-en))
  ;; (set-frame-font font-en)
  (set-face-attribute 'default nil :font (font-spec :name font-en :size 14))
  )


;; set font for chinese
(let* ((prefered-ordered-ch-font-list '("微软雅黑" "Hei" "WenQuanYi Micro Hei"))
       (font-list (font-family-list))
       (font-ch (seq-find (lambda (f) (member f font-list)) prefered-ordered-ch-font-list)))
  (message (format "set ch font to %s" font-ch))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font
     t
     charset
     font-ch
     ))
  (setq face-font-rescale-alist `((,font-ch . 1.2)))
  )

;; 你好，世界
;; abcdefgh

