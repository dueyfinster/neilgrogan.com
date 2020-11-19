;; -*- flycheck-disabled-checkers: (emacs-lisp-checkdoc); byte-compile-warnings: (not free-vars) -*-
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-refresh-contents)
(package-initialize)
(dolist (pkg '(org htmlize solarized-theme gnuplot org-plus-contrib))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(require 'org)
(require 'htmlize)
(require 'ox)
(require 'ox-html)
(require 'ox-publish)
(require 'ob-python)
(require 'solarized-theme)

(setq python-shell-interpreter "python3"
      org-babel-python-command "python3")

(setq org-ditaa-jar-path (expand-file-name "./bin/plantuml.jar")
      org-plantuml-jar-path (expand-file-name "./bin/plantuml.jar"))

(setq python-indent-guess-indent-offset t
      python-indent-guess-indent-offset-verbose nil)

(setq org-src-tab-acts-natively t
      org-src-preserve-indentation t
      org-src-fontify-natively t)

(setq org-html-inline-images t
      org-html-head-include-default-style nil
      org-html-mathjax-template ""
      org-html-htmlize-font-prefix "org-"
      org-html-htmlize-output-type (quote css)
      org-export-with-sub-superscripts nil)

;; always rebuild all files
(setq org-publish-use-timestamps-flag nil)

;; Don't ask should we eval code
(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages
'org-babel-load-languages
'((emacs-lisp . t)
  (C . t)
  (css . t)
  (dot . t)
  (ditaa . t)
  (gnuplot . t)
  (ledger . t)
  (makefile . t)
  (java . t)
  (org . t)
  (plantuml . t)
  (python . t)
  (ruby . t)
  (shell . t)))

(setq project-root (locate-dominating-file "." "_config.yml"))

(setq org-publish-project-alist
  `(
    ("org-dueyfinster"
     ;; Path to your org files.
     :base-directory ,(concat project-root "org/posts")
     :base-extension "org"
     ;; Path to your Jekyll project.
     :publishing-directory ,(concat project-root "_posts")
     :recursive t
     :publishing-function org-html-publish-to-html
     :section-numbers nil
     :headline-levels 4
     :html-extension "html"
     :body-only t
     )
    ))

(org-publish-all)