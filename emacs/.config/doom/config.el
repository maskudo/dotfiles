;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(add-to-list 'custom-theme-load-path "~/.config/doom/themes/rose-pine")
(load-theme 'doom-rose-pine t) ;; or 'rose-pine-dawn / 'rose-pine-moon

(add-to-list 'load-path "/path/to/lsp-biome/")

(setq doom-theme nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(set-frame-font "JetBrains Mono Nerd Font 12" nil t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/zt/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
(after! lsp-mode
  (setq  lsp-go-analyses '((fieldalignment . t)
                           (nilness . t)
                           (shadow . t)
                           (unusedparams . t)
                           (unusedwrite . t)
                           (useany . t)
                           (unusedvariable . t)))
  )

(add-hook 'after-make-frame-functions (lambda (f) (set-face-attribute 'default f :font "JetBrains Mono Nerd Font 12")))

(setq lsp-ui-sideline-enable t)               ;; Enable sideline
(setq lsp-ui-sideline-show-diagnostics t)    ;; Show diagnostics inline
(setq lsp-ui-sideline-ignore-duplicate t)
(setq lsp-ui-doc-position 'at-point)  ;; show docs near cursor

(use-package pdf-tools
  :mode (("\\.pdf\\'" . pdf-view-mode))
  :config
  (pdf-loader-install))
(setq pdf-view-use-scaling t) ;; optional for zoom handling

(use-package saveplace-pdf-view
  :after (:any doc-view pdf-tools)
  :demand t)

;; Save the last viewed page in bookmarks
(add-hook 'pdf-view-mode-hook
          (lambda ()
            (add-hook 'kill-buffer-hook #'pdf-view-save-memento nil t)))
(add-hook 'pdf-view-mode-hook #'pdf-view-restored-memento)


;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(map! :n "-" #'dired-jump)
(map! :n "C-u" (lambda () (interactive) (evil-scroll-up nil) (recenter))
      :n "C-d" (lambda () (interactive) (evil-scroll-down nil) (recenter))
      :n "n" (lambda () (interactive) (evil-ex-search-next) (recenter))
      :n "N" (lambda () (interactive) (evil-ex-search-previous) (recenter)))
(map! "C-S-v" #'clipboard-yank)
(map! "C-\\" #'+vterm/toggle)
(map! :n "B" "%")

(setq consult-ripgrep-args
      "rg --hidden --null --line-buffered --color=never --max-columns=1000 --path-separator / --with-filename --no-heading --line-number --smart-case .")

(map! :leader
      "/"   #'consult-ripgrep         ;; live grep (project)
      )

(map! :leader
      "[" #'+workspace/switch-left
      "]" #'+workspace/switch-right)
