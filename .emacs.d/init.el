(require 'package)
(require 'lsp)
(require 'prettier-js)
(require 'emmet-mode)
(require 'typescript-mode)
(require 'grep)
(require 'paredit)

(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; emacs settings

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

(setq backup-directory-alist
      '(("." . "~/.config/emacs")))

(setq inhibit-startup-screen t)
(setq initial-scratch-message "...")

(setq-default indent-tabs-mode nil)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(column-number-mode 1)
(display-time-mode -1)
(global-hl-line-mode)
(show-paren-mode 1)
(display-battery-mode -1)
(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "gm")
(recentf-mode 1)
(setq history-length 25)
(savehist-mode 1)

(add-hook 'focus-mode-hook #'lsp-focus-mode)
;;(add-hook 'clojure-mode-hook 
;;(focus-mode)

;; display

;; (load-theme 'gruvbox-dark-medium t)
;; (load-theme 'modus-vivendi t)
;; (load-theme 'modus-vivendi-tinted t)
;; (load-theme 'zenburn t)

(load-theme 'gruvbox-dark-hard t)


(column-number-mode 1)
(display-time-mode 1)
(global-hl-line-mode)
(show-paren-mode 1)
(display-battery-mode 1)
(setq visible-bell t)
(setq ring-bell-function 'ignore)
(beacon-mode 1)

;;(set-face-attribute 'default nil :font "Menlo-14.75")
(set-face-attribute 'default nil :font "SF Mono-14.75")

;; completion

(global-company-mode)

;; (setq tab-always-indent 'complete)

(setq company-minimum-prefix-length 1
      company-idle-delay 0.5)

(ivy-mode 1)

;; global plugins
(rg-enable-default-bindings)
(add-hook 'prog-mode-hook 'smartscan-mode)

;;(require 'golden-ratio)
;;(golden-ratio-mode 1)


;; paredit

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'cider-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)
(setq cider-repl-display-help-banner nil)

;; tree-sitter

;;(global-tree-sitter-mode)

;;(add-hook 'typescript-mode-hook #'tree-sitter-hl-mode)


;; LSP / Flymake

(setq read-process-output-max (* 1024 1024))
(setq gc-cons-threshold 100000000)
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil)
(setq lsp-eldoc-enable-hover nil)



(require 'flymake-eslint)
;; (require 'flymake-kondor)

(add-hook 'typescript-mode-hook #'flymake-eslint-enable)
(add-hook 'js-mode-hook #'flymake-eslint-enable)
;;(add-hook 'clojure-mode-hook #'flymake-kondor-setup)

;;(require 'flycheck-clj-kondo)

(add-hook 'clojure-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'js-mode-hook #'lsp)

;; this enable typescript
;; (add-hook 'js-mode-hook #'lsp)

(setq lsp-ui-doc-enable nil)
(setq lsp-lens-enable nil)

;;(add-hook 'after-init-hook #'global-flycheck-mode)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

;; (with-eval-after-load 'flycheck
;;  (set-face-attribute 'flycheck-error nil :underline '()))

(with-eval-after-load 'magit
  (require 'forge))

;; js and typescript

(add-hook 'js-mode-hook 'emmet-mode)
(add-hook 'typescript-mode-hook 'emmet-mode)

(with-eval-after-load 'js
  (define-key js-mode-map (kbd "M-.") nil))

(add-hook 'emmet-mode-hook
      (lambda () (setq emmet-indent-after-insert nil)))

;; editing

(put 'upcase-region 'disabled nil)


;; platform

(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))

;; custom fns

(defun browse-in-github ()
  "Open gh."
  (interactive)
  (print "my FUNCTION")
  (let (sha (shell-command-to-string "git rev-parse HEAD | tr -d '\n'"))
    (print (line-number-at-pos))
    (print
     (url-generic-parse-url "https://github.com/yellowdig/next/blob/1cd6cb10faf11a55d2b9017ea9e4069f116f000c/yd/datomic-http/src/yd/model/board/badge.clj#L22"))))

(defun select-sexp ()
  "Select sexp region at point."
  (interactive)
  (set-mark-command nil)
  (paredit-forward))

(require 'expand-region)

(require 'html-mode-expansions)

;; (defun er/add-html-mode-expansions ()
;;   "Adds HTML-specific expansions for buffers in html-mode"
;;       (set (make-local-variable 'er/try-expand-list)
;;          (append
;;           er/try-expand-list
;;           '(er/mark-html-attribute
;;             er/mark-inner-tag
;;             er/mark-outer-tag))))

(defun er/add-html-mode-expansions ()
  (make-variable-buffer-local 'er/try-expand-list)
  (setq er/try-expand-list
      (append
          er/try-expand-list
          '(er/mark-html-attribute
            er/mark-inner-tag
            er/mark-outer-tag))))

;;     (er/enable-mode-expansions 'text-mode 'er/add-text-mode-expansions)

;; (er/enable-mode-expansions 'js-mode 'er/add-html-mode-expansions)
(er/enable-mode-expansions 'typescript-mode 'er/add-html-mode-expansions)



;; key bindings

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)
(global-set-key (kbd "C-c C-w") 'select-sexp)
(global-set-key (kbd "s-{") 'tab-previous)
(global-set-key (kbd "s-}") 'tab-next)
(global-set-key (kbd "s-t") 'tab-new)
(global-set-key (kbd "s-w") 'tab-close)
(global-set-key (kbd "C-c C-p") 'lsp-format-buffer)
(global-set-key (kbd "C-c C-n") 'lsp-clojure-clean-ns)
(global-set-key (kbd "C-c C-f") 'prettier-js)
(global-set-key (kbd "s-{") 'tab-previous)
(global-set-key (kbd "s-}") 'tab-next)
(global-set-key (kbd "M-o") 'ace-window)


(global-set-key (kbd "C-<delete>") #'crux-kill-line-backwards)
(global-set-key (kbd "s-o") #'crux-smart-open-line-above)
(global-set-key (kbd "s-j") #'crux-top-join-line)


(grep-apply-setting
   'grep-find-command
   '("rg -e '' $(git rev-parse --show-toplevel || pwd)" . 27))
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "b54bf2fa7c33a63a009f249958312c73ec5b368b1094e18e5953adb95ad2ec3a" "0cd00c17f9c1f408343ac77237efca1e4e335b84406e05221126a6ee7da28971" "8feca8afd3492985094597385f6a36d1f62298d289827aaa0d8a62fe6889b33c" default))
 '(git-commit-summary-max-length 120)
 '(js-indent-level 2)
 '(line-spacing 0.1)
 '(list-directory-brief-switches "-1")
 '(list-directory-verbose-switches "-1")
 '(lsp-ui-sideline-enable nil)
 '(package-selected-packages
   '(which-key prettier-js dracula-theme github-modern-theme lsp-focus focus crux zenburn-theme modus-themes rg ergoemacs-mode tree-sitter-langs tree-sitter flymake-eslint flymake-kondor browse-at-remote expand-region smartparens lsp-treemacs yaml-mode smartscan treemacs zzz-to-char emmet-mode js2-mode beacon lispy lsp-ui forge gruvbox-theme ivy company typescript-mode lsp-mode graphql-mode graphql-doc graphql projectile magit paredit clojure-mode-extra-font-locking cider darkokai-theme))
 '(typescript-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:underline nil))))
 '(lsp-headerline-breadcrumb-path-error-face ((t (:inherit lsp-headerline-breadcrumb-path-face :underline "Red1"))))
 '(lsp-headerline-breadcrumb-path-hint-face ((t (:inherit lsp-headerline-breadcrumb-path-face :underline "Green"))))
 '(lsp-headerline-breadcrumb-path-info-face ((t (:inherit lsp-headerline-breadcrumb-path-face :underline "Green")))))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
