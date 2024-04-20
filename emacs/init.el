;;; init.el --- Maximilian Cook's (mcookly) Emacs Code. -*- lexical-binding: t -*-

;;; License:

;; All code is licensed under 0BSD (below) unless marked as "external code,"
;; which will linked to the source. That source dictates the code's license.

;; Zero-Clause BSD =============

;; Permission to use, copy, modify, and/or distribute this software for any
;; purpose with or without fee is hereby granted.

;; THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
;; REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
;; AND FITNESS.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
;; INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
;; LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
;; OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
;; PERFORMANCE OF THIS SOFTWARE.


;;; Commentary:

;; My config is all within this file.  Any extra code (like modes and modules)
;; can be found under `elisp`.  Some prefer splitting their config into separate
;; files ("modules"), but my needs for Emacs are simple: to write papers, keep
;; notes, and code every now-and-then.

;; My config is divided into the following sections:
;; - General
;; - MacOS/Darwin
;; - Writing
;; - Coding
;; - Hooks

;; Custom variables, if any, go into `custom.el`.


;;; Code:

;; -----------------------------------------------------------------------------
;;                                  GENERAL
;; -----------------------------------------------------------------------------


;; SETTINGS BEFORE THE SETTINGS ------------------------------------------------

;; NOTE:  The code below is from user3871 on SO (slightly modified)
;; https://emacs.stackexchange.com/a/34367.

;; >>> BEGIN EXTERNAL CODE >>>

;; Optimize startup time by…

;; Increasing garbage collection threshold (From
;; https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/)

(setq gc-cons-threshold-original gc-cons-threshold
      gc-cons-threshold (* 1024 1024 100))

;; Setting file-name-handler-alist (Also from
;; https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/)

(setq file-name-handler-alist-original file-name-handler-alist
      file-name-handler-alist nil)

;; Setting deferred timer to reset them

(run-with-idle-timer
 5
 nil
 (lambda ()
   (setq gc-cons-threshold gc-cons-threshold-original
         file-name-handler-alist file-name-handler-alist-original)

   (makunbound 'gc-cons-threshold-original)
   (makunbound 'file-name-handler-alist-original)
   (message "gc-cons-threshold and file-name-handler-alist restored")))

;; <<< END EXTERNAL CODE <<<

;; Adding extra code via `require` or `use-package` prevents pulling the same
;; code multiple times, which I usually want to avoid.
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; "Customize" should keep its grimy hands off my `init.el`. Its settings are
;; loaded at the EOF.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


;; NOTE:  The below is pulled from this GH issue:
;; https://github.com/jwiegley/use-package/issues/313.
;; (The original article no longer exists.)
;; >>> BEGIN EXTERNAL CODE >>>

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; <<< END EXTERNAL CODE <<<

;; Load themes now for faster visual configuration.

;; Doom Themes (doomemacs/themes)
(use-package doom-themes
  :if window-system
  :ensure t)


;; DEFAULTS --------------------------------------------------------------------

(add-to-list 'default-frame-alist '(font . "Cousine-14")) ; Ignored in TUI

;; `-1` disables these by default for all frames.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Allow narrowing
(put 'narrow-to-defun  'disabled nil)
(put 'narrow-to-page   'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Alphabetically sorted
(setq-default
 native-comp-async-report-warnings-errors nil
 cursor-type '(bar . 3)
 fill-column 80                         ; This is the Way
 indent-tabs-mode t
 tab-width 4
 ;; Add column number to the mode-line.  I'm not sure why it's not there by
 ;; default.
 mode-line-position (list "%p (%l:%c)")
 sentence-end-double-space nil)


;; SETTINGS --------------------------------------------------------------------

;; Alphabetically sorted
(setq
 backup-directory-alist `(("." . "~/.saves"))
 inhibit-splash-screen t                ; Start with *scratch*
 ;; Switching to fundamental mode decreases startup time.
 initial-major-mode 'fundamental-mode
 initial-scratch-message nil)           ; A blank canvas awaits…

(global-visual-line-mode t)             ; Soft-wrap respect words.
(pixel-scroll-precision-mode t)         ; Buttery smooth. Yum

;; Use <S-(arrow)> to jump across window splits.
(windmove-default-keybindings)          ; one giant leap for windowkind…

;; Grammars for Tree Sitter
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)


;; FUNCTIONS -------------------------------------------------------------------

;; NOTE:  These theme functions are created when a daemon is started, even if I
;; plan not to create any frames (which will be once in a blue moon).  I don't
;; find any point in waiting until a frame is created to set them.
(defun dark ()
  "Set theme to a dark theme."
  (interactive)
  (if (eq system-type 'darwin)
      (modify-all-frames-parameters `((ns-appearance . dark))))
  (if (require 'doom-themes nil 'noerror)
      (load-theme 'doom-plain-dark t)
    (load-theme 'leuven-dark t))
  ;; Change cursor color to match iA Writer
  (set-cursor-color "#20BBFC"))

(defun light ()
  "Set theme to a light theme."
  (interactive)
  (if (eq system-type 'darwin)
      (modify-all-frames-parameters `((ns-appearance . light))))
  (if (require 'doom-themes nil 'noerror)
      (load-theme 'doom-plain t)
    (load-theme 'leuven t))
  ;; Change cursor color to match iA Writer
  (set-cursor-color "#20BBFC"))

;; I usually use light mode.
(light)

;; PACKAGES --------------------------------------------------------------------

;; For more sources …
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)

;; Adaptive Wrap (elpa/adaptive-wrap)
(use-package adaptive-wrap
  :ensure t
  :hook ('visual-line-mode-hook 'adaptive-wrap-prefix-mode))

;; Avy (abo-abo/avy)
(use-package avy
  :ensure t
  :bind ("M-SPC" . 'avy-goto-char-timer))

;; Citar (emacs-citar/citar)
(use-package citar
  :ensure t
  :custom
  (citar-bibliography '("~/bib/library.bib"))
  :bind ("C-x M-c" . citar-insert-keys))

;; Drag Stuff (rejeep/drag-stuff)
(use-package drag-stuff
  :ensure t
  :bind
  (("C-s-<up>" . 'drag-stuff-up)
   ("C-s-<down>" . 'drag-stuff-down)
   ("C-s-<left>" . 'drag-stuff-left)
   ("C-s-<right>" . 'drag-stuff-right))
  :init
  (drag-stuff-global-mode 1))

;; Magit (magit/magit)
(use-package magit
  :ensure t)

;; Olivetti (rnkn/olivetti)
(use-package olivetti
  :ensure t
  :commands olivetti-mode
  :custom
  (olivetti-body-width 62)             ; For writing, not coding 
  :bind ("C-x M-o" . olivetti-mode))

;; Server (built-in)
(use-package server
  :ensure t
  :if window-system
  :init
  ;; Unless I'm mistaken, the server is tied to the first Emacs instance.  I
  ;; only want one server running since I plan to use only one Emacs instance.
  ;; Ever.
  (unless (server-running-p)
    (add-hook 'after-init-hook 'server-start t)))

;; Treesit Auto (renzmann/treesit-auto)
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-langs '(json lua markdown toml typst yaml))
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Typst (meow_king/typst-ts-mode)
(use-package typst-ts-mode
  :ensure t
  :vc (:fetcher sourcehut :repo meow_king/typst-ts-mode)
  :commands typst-ts-mode
  :custom
  ;; don't add "--open" if you'd like `watch` to be an error detector
  (typst-ts-mode-watch-options "--open"))

;; Vertico (minad/vertico)
(use-package vertico
  :ensure t
  :init
  (vertico-mode))


;; -----------------------------------------------------------------------------
;;                                MACOS/DARWIN
;; -----------------------------------------------------------------------------

;; NOTE:  Certain MacOS-specific settings may be tweaked by functions not in
;; this section.

(when (eq system-type 'darwin)
  ;; Ignore the most annoying type of file to ever exist.
  (add-to-list 'completion-ignored-extensions ".DS_Store")

  ;; The actual text color of the titlebar is handled by `light` and `dark`
  ;; functions.
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

  ;; Since I only use Emacs on MacOS/Darwin, I use Mac-esque bindings.
  ;; + Left CTRL:  CTRL
  ;; + Left OPT:   Meta
  ;; + Left CMD:   Super
  ;; + Right CMD:  Super
  ;; + Right OPT:  Compose
  ;; The goal is to use the thumbs and ring fingers more than pinkies.  I no
  ;; longer have access to Mac's combining key, but I can do without it.  The
  ;; CMD-CTRL mapping feels more in line with Mac's keybinding philosophy.
  (setq ns-command-modifier 'super
        ns-right-command-modifier 'super
	ns-right-option-modifier 'none))


;; -----------------------------------------------------------------------------
;;                                  WRITING
;; -----------------------------------------------------------------------------


;; PACKAGES --------------------------------------------------------------------

;; Markdown Mode (jrblevin/markdown-mode)
(use-package markdown-mode
  :ensure t
  :mode "\\.md\\'"
  :commands markdown-mode)

;; Typewriter Mode (mcookly, local)
(use-package typewriter-mode
  :commands typewriter-mode)

;; SETTINGS --------------------------------------------------------------------

(setq-default
 visual-order-cursor-movement 1)       ; Arrow keys move visual direction.


;; -----------------------------------------------------------------------------
;;                                    CODE
;; -----------------------------------------------------------------------------

;; No special packages at the moment.

;; SETTINGS --------------------------------------------------------------------

;; Typst
(setq typst-ts-mode-indent-offset 2)


;; -----------------------------------------------------------------------------
;;                                   HOOKS
;; -----------------------------------------------------------------------------

(add-hook 'emacs-lisp-mode-hook (lambda ()
								  (show-paren-mode 1)
								  (electric-pair-local-mode t)))

(add-hook 'typst-ts-mode-hook (lambda ()
									   (electric-pair-local-mode t)))

;; -----------------------------------------------------------------------------

(if (file-exists-p custom-file)
    (load custom-file))

;;; init.el ends here
