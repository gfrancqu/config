;; use melpa package

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(elpy-enable)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; dark theme base on flat ui 
(load-theme 'flatui-dark t)

;; set up line numbers
(global-linum-mode t)

;; activate CUA mode for Ctrl+C,v,x
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1)               ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t)


;; remove annoying temporary files
(setq backup-directory-alist `(("." . "~/.saves")))


(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; auto mode depending on file type
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ng2-mode elpy dockerfile-mode neotree flatui-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ng2-mode)
