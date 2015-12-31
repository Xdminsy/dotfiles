(define-key global-map "\C-x?" 'help-command)
(define-key global-map "\C-h" 'backward-delete-char)

(require 'package)
(require 'cl)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(defvar my-packages
  '(clojure-mode cider helm color-theme-sanityinc-tomorrow)
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  (loop for p in my-packages
	when (not (package-installed-p p)) do (return nil)
	        finally (return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
            (package-install p))))

(require 'color-theme)
(color-theme-initialize)
(require 'helm)
;; (global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode t)
(color-theme-sanityinc-tomorrow-night)
