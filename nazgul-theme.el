;;; nazgul-theme.el --- A simple grayscale theme

;; Copyright (C) 2018  Wil Thomason

;; Author: Wil Thomason <wbthomason@cs.cornell.edu>
;; Maintainer: Wil Thomason <wbthomason@cs.cornell.edu>
;; Version: 0.1
;; URL: https://github.com/wbthomason/emacs-nazgul-theme
;; Keywords: lisp

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This theme is a port of the vim-nazgul theme to Emacs. It is based off of grayscale-theme by Kaleb
;; Elwert. All credit for the theme goes to Kaleb; all credit for bugs goes to me.

;;; Code:

(defun nazgul-theme-transform-spec (spec colors)
  "Transform a theme `SPEC' into a face spec using `COLORS'."
  (let ((output))
    (while spec
      (let* ((key       (car  spec))
             (value     (cadr spec))
             (color-key (if (symbolp value) (intern (concat ":" (symbol-name value))) nil))
             (color     (plist-get colors color-key)))

        ;; Append the transformed element
        (cond
         ((and (memq key '(:box :underline)) (listp value))
          (setq output (append output (list key (nazgul-theme-transform-spec value colors)))))
         (color
          (setq output (append output (list key color))))
         (t
          (setq output (append output (list key value))))))

      ;; Go to the next element in the list
      (setq spec (cddr spec)))

    ;; Return the transformed spec
    output))

(defun nazgul-theme-transform-face (spec colors)
  "Transform a face `SPEC' into an Emacs theme face definition using `COLORS'."
  (let* ((face             (car spec))
         (definition       (cdr spec)))

    (list face `((t ,(nazgul-theme-transform-spec definition colors))))))

(defun nazgul-theme-set-faces (theme-name colors faces)
  "Define the important part of `THEME-NAME' using `COLORS' to map the `FACES' to actual colors."
  (apply 'custom-theme-set-faces theme-name
         (mapcar #'(lambda (face)
                     (nazgul-theme-transform-face face colors))
                 faces)))

(defvar nazgul-theme-colors
  '(
    :blackest  "#141414"
    :black     "#282828"
    :gray01    "#333333"
    :gray02    "#515151"
    :gray03    "#5b5b5b"
    :gray04    "#666666"
    :gray05    "#727272"
    :gray06    "#828282"
    :gray07    "#8c8c8c"
    :gray08    "#969696"
    :gray09    "#a0a0a0"
    :gray10    "#aaaaaa"
    :gray11    "#b5b5b5"
    :gray12    "#bfbfbf"
    :gray13    "#c9c9c9"
    :gray14    "#d3d3d3"
    :gray15    "#efefef"
    :white     "#f9f9f9"

    :purple    "#5f5fd7"
    :brown     "#875f00"
    :red-1     "#9c5353"
    :red       "#bc5353"
    :red+1     "#fc5353"
    :orange    "#ffbf8f"
    :yellow    "#fddf8d"
    :yellow+1  "#ffff8d"
    :green     "#7f9f7f"
    :green+1   "#8fb28f"
    :blue      "#005fa7"
    :blue+1    "#00afff"
    :cyan      "#8cd0d3"
    :cyan+1    "#93e0e3"
    :magenta   "#dc8cc3"
    :magenta+1 "#ec93d3"))

(deftheme nazgul)
(nazgul-theme-set-faces
 'nazgul
 nazgul-theme-colors

 '(
;;; Built-in

;;;; basic colors
   (default                                      :foreground gray13 :background black)
   (border                                       :background gray01)
   (cursor                                       :background gray02)
   (fringe                                       :background black)
   (gui-element                                  :background gray01)
   (header-line                                  :background nil :inherit mode-line)
   (highlight                                    :background gray01)
   (link                                         :foreground blue :underline t)
   (link-visited                                 :foreground magenta :underline t)
   (minibuffer-prompt                            :background black :foreground green)
   (region                                       :background gray05)
   (secondary-selection                          :background gray05)
   (trailing-whitespace                          :foreground yellow :background blue+1)
   (widget-button                                :underline t)
   (widget-field                                 :background gray12 :box (:line-width 1 :color white))

   (error                                        :foreground red    :weight bold)
   (warning                                      :foreground orange :weight bold)
   (success                                      :foreground green  :weight bold)

;;;; font-lock
   (font-lock-builtin-face                       :foreground gray15)
   (font-lock-comment-delimiter-face             :foreground gray10)
   (font-lock-comment-face                       :foreground gray10 :slant italic)
   (font-lock-constant-face                      :foreground gray11)
   (font-lock-doc-face                           :foreground gray12)
   (font-lock-doc-string-face                    :foreground gray12)
   (font-lock-function-name-face                 :foreground gray08)
   (font-lock-keyword-face                       :foreground white)
   (font-lock-negation-char-face                 :foreground gray12)
   (font-lock-preprocessor-face                  :foreground gray07)
   (font-lock-regexp-grouping-backslash          :foreground gray12)
   (font-lock-regexp-grouping-construct          :foreground gray13)
   (font-lock-string-face                        :foreground gray10)
   (font-lock-type-face                          :foreground gray05)
   (font-lock-variable-name-face                 :foreground gray08)
   (font-lock-warning-face                       :foreground brown)

;;;; isearch
   (match                                        :foreground gray01 :background gray11 :inverse-video t)
   (isearch                                      :foreground black :background gray07 :inverse-video t :weight bold)
   (lazy-highlight                               :foreground gray12 :inverse-video t)
   (isearch-fail                                 :foreground red-1 :background gray13 :inverse-video t)

;;;; line-numbers
   (line-number                                  :foreground gray04 :background gray01)
   (line-number-current-line                     :inverse-video t :inherit line-number)

;;;; mode-line
   (mode-line                                    :foreground gray11 :background gray03 :box (:line-width -1 :style released-button))
   (mode-line-buffer-id                          :foreground white :background nil)
   (mode-line-emphasis                           :foreground white :slant italic)
   (mode-line-highlight                          :foreground magenta :box nil :weight bold)
   (mode-line-inactive                           :foreground gray12 :background gray01 :box (:line-width -1 :style released-button))

;;; Third-party

;;;; anzu-mode
   (anzu-mode-line                               :foreground yellow)

;;;; company-mode
   (company-tooltip                              :background gray02 :inherit default)
   (company-scrollbar-bg                         :background white)
   (company-scrollbar-fg                         :background gray12)
   (company-tooltip-annotation                   :foreground red)
   (company-tooltip-common                       :inherit font-lock-constant-face)
   (company-tooltip-selection                    :background gray03 :inherit font-lock-function-name-face)
   (company-preview-common                       :inherit secondary-selection)

;;;; diff-hl-mode
   (diff-hl-change                               :background blue  :foreground blue+1)
   (diff-hl-delete                               :background red   :foreground red+1)
   (diff-hl-insert                               :background green :foreground green+1)

;;;; diff-mode
   (diff-added                                   :foreground green)
   (diff-changed                                 :foreground magenta)
   (diff-removed                                 :foreground red)
   (diff-header                                  :background black)
   (diff-file-header                             :background gray01)
   (diff-hunk-header                             :foreground magenta :background black)

;;;; flycheck-mode
   (flycheck-error                               :underline (:style wave :color red))
   (flycheck-info                                :underline (:style wave :color yellow))
   (flycheck-warning                             :underline (:style wave :color orange))

;;;; flyspell-mode
   (flyspell-duplicate                           :underline (:style wave :color orange))
   (flyspell-incorrect                           :underline (:style wave :color red))

;;;; helm
   ;; TODO: Clean up and finalize these colors
   (helm-M-x-key                                 :foreground cyan)
   (helm-action                                  :foreground gray13)
   (helm-buffer-directory                        :foreground gray12 :background nil :weight bold)
   (helm-buffer-file                             :foreground cyan)
   (helm-buffer-not-saved                        :foreground red)
   (helm-buffer-process                          :foreground gray12)
   (helm-buffer-saved-out                        :foreground red-1)
   (helm-buffer-size                             :foreground orange)
   (helm-candidate-number                        :foreground black :background orange)
   (helm-ff-directory                            :foreground gray12 :background nil :weight bold)
   (helm-ff-executable                           :foreground green)
   (helm-ff-file                                 :foreground cyan)
   (helm-ff-invalid-symlink                      :foreground black :background red)
   (helm-ff-prefix                               :foreground nil :background nil)
   (helm-ff-symlink                              :foreground black :background cyan)
   (helm-grep-cmd-line                           :foreground green)
   (helm-grep-file                               :foreground cyan)
   (helm-grep-finish                             :foreground black :background orange)
   (helm-grep-lineno                             :foreground gray12)
   (helm-grep-match                              :foreground yellow)
   (helm-grep-running                            :foreground orange)
   (helm-header                                  :foreground yellow :background black :underline nil)
   (helm-match                                   :foreground yellow)
   (helm-moccur-buffer                           :foreground cyan)
   (helm-selection                               :foreground nil :background gray03 :underline nil)
   (helm-selection-line                          :foreground nil :background gray03)
   (helm-separator                               :foreground gray01)
   (helm-source-header                           :foreground gray13 :background gray01 :weight bold)
   (helm-visible-mark                            :foreground black :background green)

;;;; hl-line-mode
   (hl-line                                      :background gray01)

;;;; ido-mode
   (ido-subdir                                   :foreground gray12)
   (ido-first-match                              :foreground orange :weight bold)
   (ido-only-match                               :foreground green :weight bold)
   (ido-indicator                                :foreground red :background gray01)
   (ido-virtual                                  :foreground gray12)

;;;; js2-mode
   (js2-error                                    :underline (:style wave :color red))
   (js2-external-variable                        :foreground orange)
   (js2-function-call                            :foreground white)
   (js2-function-param                           :foreground gray12)
   (js2-instance-member                          :foreground white)
   (js2-jsdoc-html-tag-name                      :foreground white)
   (js2-jsdoc-html-tag-delimiter                 :foreground gray12)
   (js2-jsdoc-tag                                :foreground white)
   (js2-jsdoc-type                               :foreground gray13)
   (js2-jsdoc-value                              :foreground gray13)
   (js2-object-property                          :foreground white)
   (js2-private-member                           :foreground white)
   (js2-private-function-call                    :foreground white)
   (js2-warning                                  :underline (:style wave :color orange))

;;;; magit
   ;; TODO: These are experimental colors and may be changed or removed later
   (magit-diff-added                             :foreground green)
   (magit-diff-added-highlight                   :foreground green+1)
   (magit-diff-base                              :foreground yellow)
   (magit-diff-base-highlight                    :foreground yellow+1)
   (magit-diff-conflict-heading                  :background gray02)
   (magit-diff-context                           :foreground gray13 :background black)
   (magit-diff-context-highlight                 :background gray01)
   (magit-diff-file-heading                      :foreground gray13 :background black)
   (magit-diff-file-heading-highlight            :foreground gray13 :background gray01)
   (magit-diff-file-heading-selection            :foreground red :background black)
   (magit-diff-hunk-heading                      :background gray02)
   (magit-diff-hunk-heading-highlight            :background gray03)
   (magit-diff-hunk-heading-selection            :foreground red :background gray03)
   (magit-diff-hunk-region                       :foreground gray13 :background black)
   (magit-diff-lines-boundary                    :foreground orange)
   (magit-diff-lines-heading                     :foreground orange)
   (magit-diff-our                               :foreground red)
   (magit-diff-our-highlight                     :foreground red+1)
   (magit-diff-removed                           :foreground red)
   (magit-diff-removed-highlight                 :foreground red+1)
   (magit-diff-their                             :foreground green)
   (magit-diff-their-highlight                   :foreground green+1)
   (magit-diff-whitespace-warning                :inherit trailing-whitespace)
   (magit-diffstat-added                         :foreground green)
   (magit-diffstat-removed                       :foreground red)

;;;; org-mode
   ;; TODO: Most of these shouldn't use accent colors.
   (org-agenda-structure                         :foreground magenta)
   (org-agenda-date                              :foreground blue :underline nil)
   (org-agenda-done                              :foreground green)
   (org-agenda-dimmed-todo-face                  :foreground gray12)
   (org-block                                    :foreground gray13)
   (org-code                                     :foreground gray13)
   (org-column                                   :background gray01)
   (org-column-title                             :weight bold :underline t :inherit org-column)
   (org-date                                     :foreground magenta :underline t)
   (org-document-info                            :foreground blue+1)
   (org-document-info-keyword                    :foreground green)
   (org-document-title                           :foreground orange :weight bold :height 1.44)
   (org-done                                     :foreground green)
   (org-ellipsis                                 :foreground gray12)
   (org-footnote                                 :foreground blue+1)
   (org-formula                                  :foreground red)
   (org-hide                                     :foreground gray12)
   (org-link                                     :foreground blue)
   (org-scheduled                                :foreground green)
   (org-scheduled-previously                     :foreground orange)
   (org-scheduled-today                          :foreground green)
   (org-special-keyword                          :foreground orange)
   (org-table                                    :foreground magenta)
   (org-todo                                     :foreground red)
   (org-upcoming-deadline                        :foreground orange)
   (org-warning                                  :foreground orange :weight bold)

;;;; show-paren-mode
   (show-paren-match                             :inverse-video t)
   (show-paren-mismatch                          :background red :inverse-video t)))

   

;; Anything leftover that doesn't fall neatly into a face goes here.
(let ((black      (plist-get nazgul-theme-colors :black))
      (gray13      (plist-get nazgul-theme-colors :fg))
      (red     (plist-get nazgul-theme-colors :red))
      (green   (plist-get nazgul-theme-colors :green))
      (yellow  (plist-get nazgul-theme-colors :yellow))
      (blue    (plist-get nazgul-theme-colors :blue))
      (magenta (plist-get nazgul-theme-colors :magenta))
      (cyan    (plist-get nazgul-theme-colors :cyan)))
  (custom-theme-set-variables
   'nazgul
   `(ansi-color-names-vector
     ;; black, base08, base0B, base0A, base0D, magenta, cyan, white
     [,black ,red ,green ,yellow ,blue ,magenta ,cyan ,gray13])
   `(ansi-term-color-vector
     ;; black, base08, base0B, base0A, base0D, magenta, cyan, white
     [unspecified ,black ,red ,green ,yellow ,blue ,magenta ,cyan ,gray13])))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'nazgul)

;;; nazgul-theme.el ends here
