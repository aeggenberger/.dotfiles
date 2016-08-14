(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
					; save clock history across emacs sessions
(setq org-clock-ersist 'history)
(org-clock-persistence-insinuate)
(require 'xscheme)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(org-agenda-files
   (quote
    ("/Volumes/homes/Andrew/Dropbox/Graphic/org/graphic.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

 '(org-agenda-files
   (quote
    ("/Volumes/homes/Andrew/Dropbox/Graphic/org/graphic.org")))

;; (require 'evil)
;; Enable Evil mode ad default
;; (evil-mode 1)
;; SECOND THOUGHTS!!!!

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (scheme . t)
   ))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
