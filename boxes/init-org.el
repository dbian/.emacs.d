;; -*- lexical-binding: t; -*-


;; 修改agenda的标题
(defun org-agenda-format-date-aligned (date)
  (require 'cal-iso)
  (let* ((dayname (calendar-day-name date))
         (day (cadr date))
         (day-of-week (calendar-day-of-week date))
         (month (car date))
         (monthname (calendar-month-name month))
         (year (nth 2 date))
         (iso-week (org-days-to-iso-week
                    (calendar-absolute-from-gregorian date)))
         (weekyear (cond ((and (= month 1) (>= iso-week 52))
                          (1- year))
                         ((and (= month 12) (<= iso-week 1))
                          (1+ year))
                         (t year)))
         (weekstring (if (= day-of-week 1)
                         (format "全年第%02d周" iso-week)
                       "")))
    (format "%-10s %4d-%02d-%2d %s"
            dayname year month day weekstring))

  )

(use-package org-download
  :config
  ;; Drag-and-drop to `dired`
  (add-hook 'dired-mode-hook 'org-download-enable))

(defun org-screenshot-on-windows10 ()
  (interactive)
  (setq full-file-name (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
  ;; 如果文件名的长度小于14,放到mainImage文件夹下面
  (setq before-file-name-part "img")

  (setq imagefile (concat "./" before-file-name-part "/"))
  (unless (file-exists-p imagefile)
    (make-directory imagefile))
  (setq filename (concat (make-temp-name (concat imagefile
                                                 (format-time-string "%Y%m%d_%H%M%S_")))
                         ".png"))
  (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('"
                         filename "',[System.Drawing.Imaging.ImageFormat]::Png); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))

(defun copy-region-org-table-as-csv ()
  "Export the current org table as a CSV and copy it to the clipboard."
  (interactive)
  (if (use-region-p)
      (let ((table-begin (region-beginning))
            (table-end (region-end)))
        (when (org-at-table-p table-begin)
	  ; TODO
          ))
    (message "No active region or not an org table.")))

(use-package org-modern
  :config
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
  )

(defvar org-my-dir (if-win-or-else "D:/dev-diary" "~/ws/dev-diary"))
; set agenda folder
(setq org-agenda-files (directory-files-recursively org-my-dir "\\.org$"))

(setq org-capture-templates
      `(("t" "all kinds of todos" entry
	 (file ,(concat org-my-dir "/inbox.org"))
	 "* TODO %? :: Captured @ %T%^{Effort|2d}p" :prepend t :jump-to-captured t)
	("c" "new comprehension on things" entry
	 (file ,(concat org-my-dir "/comprehension.org"))
	 "* %? :: added @ %T" :prepend t :jump-to-captured t)))


;; ;; org mode
;; (global-set-key (kbd "C-c a") #'org-agenda)
;; (global-set-key (kbd "C-c c") #'org-capture)
;; (global-set-key (kbd "C-c b") #'org-switchb)

(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
;; (setq org-directory "~/ws/dev-diary")


(defun add-schedule-to-new-todo ()
  "Function to add schedule timestamp to new todo."  
    (when (equal org-state "TODO")
       (org-schedule nil (with-temp-buffer (org-time-stamp '(16)) (buffer-string)))))

(add-hook 'org-after-todo-state-change-hook 'add-schedule-to-new-todo)


(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))
