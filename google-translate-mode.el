;;; google-translate-mode.el --- Emacs minor mode for displaying translated text using Google Translate in real time.
;;
;; Copyright (C) 2013  Yuto Kawamura(kawamuray) <kawamuray.dadada at gmail.com>
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.
;;
;; Author: Yuto Kawamura(kawamuray) <kawamuray.dadada at gmail.com>
;; Requires: google-translate.el (https://github.com/manzyuk/google-translate)
;; URL: https://github.com/kawamuray/google-translate-mode
;;
;;; Installation
;; This package requires google-translate.el(https://github.com/manzyuk/google-translate) as it's backend.
;; Please install it first if you haven't installed yet.
;; Make sure that 'google-translate-mode.el' is placed in correct location which included in load-path.
;; Add following lines to your .emacs file.
;;
;;    (require 'google-translate-mode)
;;
;; You can customize time to wait before execute translate from when idle state has began.
;;
;;    (custom-set-variables '(google-translate-mode-idle-wait-time 0.2))
;;
;;; Usage
;; Just enable google-translate-mode in buffer you want to translate.
;;
;;     M-x google-translate-mode RET

(require 'google-translate)

(defconst google-translate-mode-version "0.01"
  "Google translate mode version number.")

(defvar google-translate-mode-hook nil
  "Hook run when entering Google translate mode")

(defcustom google-translate-mode-idle-wait-time 0.5
  "Seconds to wait on idle until execute translate")

(defun google-translate-mode-exec-translate()
  "Execute translate on current buffer keepking state."
  (setq google-translate-mode-exec-timer nil)
  (save-excursion
    (mark-whole-buffer)
    (google-translate-at-point)
    )
  )

(defun google-translate-mode-set-timer(a b c) ; all unused
  "Setup timer for execute translate if it is still not set."
  (unless google-translate-mode-exec-timer
    (setq google-translate-mode-exec-timer
          (run-with-idle-timer google-translate-mode-idle-wait-time nil
                               'google-translate-mode-exec-translate)))
  )

(defun google-translate-mode-enable()
  "Enable google-translate-mode."
  (set (make-local-variable 'google-translate-mode-exec-timer) nil)
  (set (make-local-variable 'after-change-functions) nil)
  (add-hook 'after-change-functions 'google-translate-mode-set-timer)
  )

(defun google-translate-mode-disable()
  "Disable google-translate-mode."
  (kill-local-variable 'google-translate-mode-exec-timer)
  (kill-local-variable 'after-change-functions)
  (remove-hook 'after-change-functions 'google-translate-mode-set-timer)
  )

(define-minor-mode google-translate-mode
  "Minor mode for displaying translated text using Google Translate in real time."
  :lighter " GoogleTranslate"
  (if google-translate-mode
      (google-translate-mode-enable)
    (google-translate-mode-disable))
  )

(provide 'google-translate-mode)
