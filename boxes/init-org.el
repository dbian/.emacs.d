

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

(defvar org-my-dir (if-win-or-else '("D:/dev-diary") '("~/ws/dev-diary")))
; set agenda folder
(org-agenda-files org-my-dir)

(setq org-capture-templates
      `(("t" "all kinds of todos" entry
	 (file ,(concat (car org-my-dir) "/inbox.org"))
	 "* TODO %? :: Captured @ %T%^{Effort|2d}p" :prepend t :jump-to-captured t)
	("c" "new comprehension on things" entry
	 (file ,(concat (car org-my-dir) "/comprehension.org"))
	 "* %? :: added @ %T" :prepend t :jump-to-captured t)))
