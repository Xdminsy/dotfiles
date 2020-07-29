(define-key global-map "\C-x?" 'help-command)
(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map (kbd "C-;") 'comment-line)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq custom-file "~/.emacs.d/xdminsy/custom-file.el")
(setq tab-width 4)
(set-language-environment "UTF-8")
(setq ring-bell-function 'ignore)

(require 'cl)
(require 'package)
(setq package-archives '(
                         ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("melpa stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
                         ("marmalade" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/marmalade/")
                         ;; ("gnu" . "http://elpa.gnu.org/packages/")
                         ;; ("marmalade" . "https://marmalade-repo.org/packages/")
                         ;; ("melpa stable" . "https://stable.melpa.org/packages/")
                         ;; ("melpa" . "http://melpa.org/packages/")
                         )
      package-archive-priorities '(("gnu" . 10)
                                   ("marmalada" .  8)
                                   ("melpa stable" . 5)
                                   ("melpa" . 0)))
(package-initialize)
(defvar my-packages
  '(
    use-package
    helm
    color-theme-sanityinc-tomorrow
    company
    doom-themes
    spacemacs-theme
    cl
    auto-complete
    emms
    magit
    ivy
    swiper
    projectile
    evil
    evil-escape
    evil-easymotion
    evil-surround
    centaur-tabs
    helm-swoop
    swiper-helm
    lsp-mode
    lsp-ui
    ;; autopair ; Use builtin electric-pair-mode instead
    ;; 2048-game
    )
  "A list of packages to ensure are installed at launch.")

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

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

;; (require 'helm)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (helm-mode t)
;; (define-key helm-find-files-map (kbd "C-j") 'helm-ff-RET)

(electric-pair-mode)
;; (require 'autopair)
;; (autopair-global-mode)
;; (ac-config-default)
;; (global-set-key (kbd "C-j") 'autopair-newline)

(require 'company)
(global-company-mode t)

(require 'doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(load-theme 'doom-one t)
(doom-themes-neotree-config)
(setq doom-themes-treemacs-config "doom-colors")
(doom-themes-treemacs-config)
(doom-themes-org-config)

;; (require 'auto-complete)
;; (auto-complete-mode t)

(require 'whitespace)
(setq whitespace-style '(face tabs spaces trailing lines space-before-tab indentation space-after-tab space-mark tab-mark))
(whitespace-mode t)

(require 'emms-setup)
(emms-standard)
(emms-default-players)

(require 'projectile)
(projectile-global-mode)

(require 'centaur-tabs)
(centaur-tabs-mode t)

(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(setq-default evil-cross-lines t)
(require 'evil-escape)
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "jk")
(require 'evil-easymotion)
(evilem-default-keybindings "SPC")
(evilem-define (kbd "SPC l") 'evil-forward-word-begin)
(evilem-define (kbd "SPC h") 'evil-backward-word-begin)
(require 'evil-surround)
(global-evil-surround-mode 1)

(evil-set-leader 'normal (kbd ";"))
(evil-set-leader 'visual (kbd ";"))
(evil-define-key 'normal 'global (kbd "<leader>w") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>q") 'save-buffers-kill-terminal)
;; (evil-define-key 'insert 'lisp-interaction-mode-map (kbd "C-j") 'eval-print-last-sexp)
;; (define-key evil-insert-state-map (kbd "C-j") 'autopair-newline)
(define-key evil-insert-state-map (kbd "C-p") 'previous-line)
(define-key evil-insert-state-map (kbd "C-n") 'next-line)
(define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "C-d") 'delete-char)
(define-key evil-insert-state-map (kbd "C-j") 'newline)

(require 'swiper-helm)
(define-key global-map (kbd "C-s") 'swiper)

(global-hl-line-mode t)
(global-auto-revert-mode t)
;; (blink-cursor-mode t)
(column-number-mode t)
(show-paren-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode t)
;; (global-display-line-numbers-mode)
;; (setq line-move-visual t)
(setq disabled-command-function nil)
;; (set-frame-parameter nil 'undecorated t)
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil)  ; stop creating #file files
(setq-default indent-tabs-mode nil)

(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(setq tab-stop-list (number-sequence 4 120 4))

(defun my-command-error-function (data context caller)
  (when (not (memq (car data) '(beginning-of-buffer
                                end-of-buffer)))
    (command-error-default-function data context caller)))
(setq command-error-function #'my-command-error-function)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(desktop-save-mode 1)
;; (set-frame-position (selected-frame) 600 100)

;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

(global-set-key [C-return] 'open-next-line)
(global-set-key [C-S-return] 'open-previous-line)
(defvar newline-and-indent t)

(load "./xdminsy/custom-file.el" 'noerror)
