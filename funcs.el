;;; funcs.el --- Debug layer function file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: troy.j.hinckley <troy.hinckley@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defun debug-short-key-state (modeon)
  "Set evil-evilified-state explicitly."
  (if modeon
      (evil-evilified-state)
    (evil-normal-state)))

(defun debug-generate-symbol (debugger)
  "create realgud interactive function name from debugger"
  (intern (concat "realgud:" debugger)))

(defun spacemacs/add-realgud-debugger (mode debugger)
  "added a deubbger to major mode.
Note that this function MUST be called BEFORE init-realgud.
Therefore you should add it to a pre-init-realgud definition"
  (let ((dbg-name (debug-generate-symbol debugger)))
    (add-to-list 'debug-autoload-debuggers dbg-name)
    (spacemacs/set-leader-keys-for-major-mode mode
      "dd" dbg-name
      "d." 'spacemacs/realgud-transient-state/body
      "db" 'debug--realgud-set-break
      "de" 'debug--realgud-eval-dwim
      "dJ" 'realgud:cmd-jump)
    ))

(defun debug--mark-symbol-at-point ()
  "Select the symbol under cursor, if using `evil' go into
`visual' state and expand the visual selection."
  (interactive)
  (when (not (use-region-p))
    (let ((b (bounds-of-thing-at-point 'symbol)))
      (goto-char (car b))
      (set-mark (cdr b))
      (when (and (featurep 'evil) evil-mode)
        (evil-visual-state)
        (evil-visual-expand-region)))))

(defun debug--realgud-init ()
  (interactive)
  (when (not (realgud-get-cmdbuf))
    (realgud-short-key-mode)))

(defun debug--realgud-set-break ()
  (interactive)
  (debug--realgud-init)
  (realgud:cmd-break))

(defun debug--realgud-eval-dwim ()
  (interactive)
  (when (not (use-region-p))
    (debug--mark-symbol-at-point))
  (realgud:cmd-eval-dwim)
  (when (and (featurep 'evil) evil-mode)
    (call-interactively 'evil-exit-visual-state)))
