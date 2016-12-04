(define-key global-map "\C-x?" 'help-command)
(define-key global-map "\C-h" 'backward-delete-char)

(require 'package)
(setq package-archives '(("popkit" . "https://elpa.popkit.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(defvar my-packages
  '(clojure-mode
      cider
      helm
      color-theme-sanityinc-tomorrow
      autopair
      cl
      auto-complete)
  "A list of packages to ensure are installed at launch.")

(require 'cl)

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
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files) 
(helm-mode t)

;; (add-to-list 'load-path "~/.emacs.d/elpa/autopair")

(require 'autopair)
(autopair-global-mode)
(ac-config-default)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
