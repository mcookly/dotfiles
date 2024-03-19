;;; typewriter-mode.el --- Static cursor positioning while typing. -*- lexical-binding: t -*-

;;; Commentary:

;; I owe this hack to Chris Wellons at null program.  Here's the original post:
;; https://nullprogram.com/blog/2013/02/06/.

;; The actually structure of the mode is roughly based on `olivetti.el`, which
;; you can find here:  https://github.com/rnkn/olivetti.


;;; Code:

;; INTERNAL VARIABLES ----------------------------------------------------------

(defvar-local typewriter/scroll-preserve-screen-position
    nil
  "Value of `scroll-preserve-screen-position` when `typewriter-mode` is enabled.")

(defvar-local typewriter/scroll-conservatively
    nil
  "Value of `scroll-conservatively` when `typewriter-mode` is enabled.")

(defvar-local typewriter/maximum-scroll-margin
    nil
  "Value of `maximum-scroll-margin` when `typewriter-mode` is enabled.")

(defvar-local typewriter/scroll-margin
    nil
  "Value of `scroll-margin` when `typewriter-mode` is enabled.")


;; DEFINITION ------------------------------------------------------------------

(define-minor-mode typewriter-mode
  "Recover the good old days."
  :lighter " Typewriter"
  (if typewriter-mode
      (progn
        ;; Bind original values.
        (unless (bound-and-true-p typewriter/scroll-preserve-screen-position)
          (setq typewriter/scroll-preserve-screen-position
                scroll-preserve-screen-position))
        (unless (bound-and-true-p typewriter/scroll-conservatively)
          (setq typewriter/scroll-conservatively scroll-conservatively))
        (unless (bound-and-true-p typewriter/maximum-scroll-margin)
          (setq typewriter/maximum-scroll-margin maximum-scroll-margin))
        (unless (bound-and-true-p typewriter/scroll-margin)
          (setq typewriter/scroll-margin scroll-margin))

        ;; Change original values to enable typewriter-mode.
        (setq scroll-preserve-screen-position t
              scroll-conservatively 0
              maximum-scroll-margin 0.5
              scroll-margin 99999))
    
    ;; Restore original values.
    (setq scroll-preserve-screen-position typewriter/scroll-preserve-screen-position
          scroll-conservatively typewriter/scroll-conservatively
          maximum-scroll-margin typewriter/maximum-scroll-margin
          scroll-margin typewriter/scroll-margin)

    ;; Remove local variables.
    (mapc #'kill-local-variable '(typewriter/scroll-preserve-screen-position
                                  typewriter/scroll-conservatively
                                  typewriter/maximum-scroll-margin
                                  typewriter/scroll-maring))))

(provide 'typewriter-mode)

;;; typewriter-mode.el ends here
