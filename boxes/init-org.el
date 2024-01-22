

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
  (interactive)
  
  )
