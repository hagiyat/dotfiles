;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "CodeNewRoman Nerd Font Mono" :size 14.0)
      doom-variable-pitch-font (font-spec :family "sans" :size 12.0))
(defadvice! add-my-font-config (&rest _)
  :after #'unicode-fonts--setup-1
  (set-fontset-font t 'japanese-jisx0208 (font-spec :family "Source Han Sans JP" :size 12.0))
  )
(setq doom-unicode-font (font-spec :family "Noto Color Emoji"))
(setq-default line-spacing 2)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(add-to-list 'custom-theme-load-path "~/.config/doom/themes")
;; (setq doom-theme 'doom-spacegrey-custom)
(setq doom-theme 'doom-wilmersdorf-custom)
(when (file-exists-p "~/.config/doom/banners")
  (setq fancy-splash-image "~/.config/doom/banners/doom_banner.png"))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq deft-directory "~/Dropbox/notes/"
      deft-extensions '("md"))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq company-idle-delay 0.2)

(setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes")

;; ime
(defun force-ime-off ()
  (interactive)
  (shell-command-to-string "[ `fcitx-remote` -eq 2 ] && fcitx-remote -c"))
(add-hook! 'evil-normal-state-entry-hook 'force-ime-off)

;; company workaround
(defun ans/unset-company-maps (&rest unused)
  "Set default mappings (outside of company).
Arguments (UNUSED) are ignored."
  (general-def
    :states 'insert
    :keymaps 'override
    "<up>" nil
    "<down>" nil
    "C-j" nil
    "C-k" nil
    "RET" nil
    [return] nil))

(defun ans/set-company-maps (&rest unused)
  "Set maps for when you're inside company completion.
Arguments (UNUSED) are ignored."
  (general-def
    :states 'insert
    :keymaps 'override
    "<down>" 'company-select-next
    "<up>" 'company-select-previous
    "C-j" 'company-select-next
    "C-k" 'company-select-previous
    "RET" 'company-complete
    [return] 'company-complete))
(add-hook 'company-completion-started-hook 'ans/set-company-maps)
(add-hook 'company-completion-finished-hook 'ans/unset-company-maps)
(add-hook 'company-completion-cancelled-hook 'ans/unset-company-maps)
