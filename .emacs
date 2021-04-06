;; emacs configuration, for use with Vagrant running
;; Ubuntu 14.04.6 LTS trusty on VirtualBox over SSH.
;; the tab indentation are betty style as required
;; by Holberton School

(setq c-default-style "bsd"
      c-basic-offset 8
      tab-width 8
      indent-tabs-mode t)

;; Highlights whitespaces and lines over 80 characters.
(require 'whitespace)
(setq whitespace-style '(face empty lines-tail trailing))
(setq whitespace-line-column 80)
(global-whitespace-mode t)

;; Turn on whitespace mode when entering a c-type or python file.
(add-hook 'c-mode-common-hook 'whitespace-mode)
(add-hook 'python-mode 'whitespace-mode)

(setq column-number-mode t)

;;disable backup
(setq backup-inhibited t)

;;disable auto save
(setq auto-save-default nil)

;; make {copy, cut, paste, undo} have {C-c, C-x, C-v, C-z} keys
(cua-mode 1)

;; auto insert closing bracket
(electric-pair-mode 1)

;; make cursor movement stop in between camelCase words.
(global-subword-mode 1)

;; make typing delete/overwrites selected text
(delete-selection-mode 1)

;; turn on bracket match highlight
(show-paren-mode 1)

;; remember cursor's last position.
(if (version< emacs-version "25.0")
    (progn
      (require 'saveplace)
      (setq-default save-place t))
(save-place-mode 1))

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; diplay line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; show cursor position within line
(column-number-mode 1)

;; display line number by default
(global-linum-mode t)

;; Display line number wider
(setq linum-format "%3d\u2502 ")

;; set default style for c code
(setq c-default-style "linux" c-basic-offset 4)

;; Sets tabulation spaces.
(setq-default indent-tabs-mode nil)
(setq-default js-indent-level 2)

;; make tab key always call a indent command.
(setq-default tab-always-indent t)

;; make tab key call indent command or insert tab character, depending on cursor position
(setq-default tab-always-indent nil)

;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)

;; Bind f5 to comment and f6 to uncomment region. 
(global-set-key [f5] 'comment-region)
(global-set-key [f6] 'uncomment-region)

;; Bind f7 key to rectangle selection. 
(global-set-key [f7] 'cua-rectangle-mark-mode)

;; Bind f8 key to re-load file from disc.
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))
(global-set-key [f8] 'revert-buffer-no-confirm)

;; Bind C-x C-<up> to move line up 
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))
(global-set-key (kbd "C-x C-<up>") 'move-line-up)

;; Bind C-x C-<down> to move line down 
(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))
(global-set-key (kbd "C-x C-<down>") 'move-line-down)

;; Disables overly aggressive indentation, for recent emacs versions.
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

(add-to-list
;; Pretty print json files when they're opened 
 'auto-mode-alist
 '("\\.json\\'" . (lambda ()
		    (javascript-mode)
		    (json-pretty-print (point-min) (point-max))
		    (goto-char (point-min))
		    (set-buffer-modified-p nil))))
;; ------------------------------------------------------------------------- ;;
;;                            Added lisp packages.                           ;;
;; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;;
;;                                                                           ;;
;; Tells emacs where the elisp lib dir is.
(add-to-list 'load-path "~/.emacs.d/lisp/") ;; <--- Uncomment this line

;; 01. Loads Indent-guide package.
;; Use the command below for downloading the indent higlight file:
;;
;;     wget https://github.com/zk-phi/indent-guide/raw/master/indent-guide.el -P ~/.emacs.d/lisp
;;
(load "indent-guide")
;;
;; Sets color of indentation-guide character.
;;
(set-face-foreground 'indent-guide-face "color-243")
(indent-guide-global-mode)

;; To enable completion install the package running the command:
;;  M-x list-packages and find the company package.
;;
;; 02. Enables complete-anything on all buffers.
;;(add-hook 'after-init-hook 'global-company-mode) ;; <---Uncomment this line.

;; Adds Melpa packages
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
