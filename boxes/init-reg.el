

(defun serialize-register-alist ()
  "Serializes the register-alist to .reg file."
  (interactive)
  (let ((register-string (prin1-to-string register-alist)))
    (with-temp-buffer
      (insert register-string)
      (write-region (point-min) (point-max) "~/.reg")
      (message "Register-alist serialized to .reg file."))))


(defun deserialize-register-alist ()
  "Deserializes the register-alist from .reg file."
  (interactive)
  (let ((register-string (insert-file-contents "~/.reg")))
    (setq register-alist (read register-string))))

