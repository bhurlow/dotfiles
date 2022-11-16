
(require 'package)

(setq package-archives
      '(
        ("melpa" . "https://melpa.org/packages/")))
        ; ("melpa stable" . "https://stable.melpa.org/packages/")))
        ; ("elpa" . "https://elpa.gnu.org/packages/")
        ; ("gnu" . "https://elpa.gnu.org/packages/")))


;; (load-theme 'darkokai t)
(load-theme 'gruvbox-dark-medium t)

(column-number-mode 1)
(display-time-mode 1)
(global-hl-line-mode)
(show-paren-mode 1)
(display-battery-mode 1)

(setq tab-always-indent 'complete)

(global-company-mode)

(setq visible-bell t)
(setq ring-bell-function 'ignore)

(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))


(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "hey now")

(global-set-key (kbd "s-{") 'tab-previous)
(global-set-key (kbd "s-}") 'tab-next)

(global-set-key (kbd "C-c C-p") 'lsp-format-buffer)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(set-face-attribute 'default nil :font "Menlo-15:spacing=210")

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'cider-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)

(add-hook 'clojure-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)


;; (require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'typescript-mode-hook
      (lambda ()
          (setq lsp-disabled-clients '(ts-ls))))


;;(set-face-attribute 'flycheck-warning nil :underline nil)

; (flycheck-add-mode 'javascript-eslint 'js-mode)

;; (setq-default flycheck-disabled-checkers
;;  (append flycheck-disabled-checkers
;;    '(javascript-jshint)))

(with-eval-after-load 'flycheck
 (set-face-attribute 'flycheck-error nil :underline '()))

(require 'flycheck-clj-kondo)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(gruvbox-theme ivy company typescript-mode lsp-mode flycheck-clj-kondo graphql-mode graphql-doc graphql flycheck projectile magit paredit clojure-mode-extra-font-locking cider darkokai-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t nil))))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
(put 'upcase-region 'disabled nil)
