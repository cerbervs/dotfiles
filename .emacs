(require 'package)
(add-to-list 'package-archives
	     '("melpa"				.	"https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#e8e8e8")
 '(company-quickhelp-color-foreground "#444444")
 '(custom-enabled-themes (quote (moe-dark)))
 '(custom-safe-themes
   (quote
    ("ae65ccecdcc9eb29ec29172e1bfb6cadbe68108e1c0334f3ae52414097c501d2" "19b9349a6b442a2b50e5b82be9de45034f9b08fa36909e0b1be09433234610bb" default)))
 '(fci-rule-color "#eeeeee")
 '(nrepl-message-colors
   (quote
    ("#8f4e8b" "#8f684e" "#c3a043" "#397460" "#54ab8e" "#20a6ab" "#3573b1" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (general key-chord org-evil evil rotate ace-window ace-mc ace-jump-mode xclip powerline helm-clojuredocs helm-cider helm moe-theme zenburn-theme neotree doneburn-theme rainbow-delimiters company cider)))
 '(pdf-view-midnight-colors (quote ("#444444" . "#eeeeee")))
 '(safe-local-variable-values
   (quote
    ((cider-shadow-cljs-default-options . "app")
     (cider-default-cljs-repl . shadow))))
 '(vc-annotate-background "#f9f9f9")
 '(vc-annotate-color-map
   (quote
    ((20 . "#844880")
     (40 . "#8f4e8b")
     (60 . "#8f684e")
     (80 . "#cfb56e")
     (100 . "#c3a043")
     (120 . "#c3a043")
     (140 . "#2a5547")
     (160 . "#397460")
     (180 . "#3b7863")
     (200 . "#438972")
     (220 . "#4c9a80")
     (240 . "#54ab8e")
     (260 . "#20a6ab")
     (280 . "#234d76")
     (300 . "#295989")
     (320 . "#2e659c")
     (340 . "#3573b1")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'prog-mode-hook (global-company-mode t))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))


;; neotree stuffs -
;; -enable,
;; -toggle setting [f8],
;; -find file/open node on start
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;; electric pair - close delimiters
(electric-pair-mode [:electric-pair-preserve-balance 1
		     :electric-pair-delete-adjacent-pairs 1])


;; powerline
(require 'powerline)

;; moe theme
(require 'moe-theme)
(powerline-moe-theme)
(moe-theme-set-color 'cyan)
(moe-dark)

;; helm 
(global-set-key (kbd "M-x") 'helm-M-x)

;; custom keys - text alignment
(global-set-key (kbd "C-c a a") 'align)
(global-set-key (kbd "C-c a e") 'align-entire)
(global-set-key (kbd "C-c a c") 'align-current)


;; custom load path
(add-to-list 'load-path "~/.emacs.d/elpa")

;; windows resize
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; switch windows easily
(global-set-key (kbd "C-M-l") (kbd "C-x o"))

;; turn menu bar off
(menu-bar-mode -1)

;;ace jump
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(define-key global-map (kbd "C-c 0") 'ace-jump-mode)
(global-set-key (kbd "C-c )") 'ace-mc-add-multiple-cursors)
(global-set-key (kbd "C-c C-c )") 'ace-mc-add-single-cursor)

;; evil
(require 'evil)
(evil-mode 1)

;; remap ,, to <esc>
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-normal-state-map ",," 'evil-force-normal-state)
(key-chord-define evil-visual-state-map ",," 'evil-change-to-previous-state)
(key-chord-define evil-insert-state-map ",," 'evil-normal-state)
(key-chord-define evil-replace-state-map ",," 'evil-normal-state)

(require 'general)

(general-evil-setup)

(general-nmap "SPC" (general-key-dispatch nil
		      "mx" 'helm-M-x
		      "w" 'ace-window
		      "j" 'ace-jump-mode
		      "xw" 'delete-window
		      "xb" 'kill-buffer
		      "ff" 'helm-find-files
		      "b" 'helm-buffers-list
		      "s|" 'split-window-horizontally
		      "s-" 'split-window-vertically
		      "zz" 'suspend-emacs))

(general-swap-key nil 'motion
  ";" ":"
  "j" "gj"
  "k" "gk")

(general-imap "j"
  (general-key-dispatch 'self-insert-command
    :timeout 0.25
    "k" 'evil-normal-state))
