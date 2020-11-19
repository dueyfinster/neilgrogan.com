(require 'package)
(package-initialize)
(unless package-archive-contents
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-refresh-contents))
(dolist (pkg '(dash projectile org-plus-contrib htmlize))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(require 'org)
(require 'ox-publish)

;; setting to nil, avoids "Author: x" at the bottom
(setq user-full-name nil)

;; always rebuild all files
(setq org-publish-use-timestamps-flag nil)

(setq org-export-with-section-numbers nil
      org-export-with-smart-quotes t
      org-export-with-toc nil)

(setq org-html-divs '((preamble "header" "site-header")
                      (content "main" "content")
                      (postamble "footer" "postamble"))
      org-html-container-element "section"
      org-html-metadata-timestamp-format "%Y-%m-%d"
      org-html-checkbox-type 'html
      org-html-html5-fancy t
      org-html-validation-link nil
      org-html-doctype "html5")

(defun include-html (name)
  "Formats the pre/postamble named NAME by reading a file from the includes directory."
  `(("en" ,(with-temp-buffer
             (insert-file-contents (expand-file-name (format "%s.html" name) "./includes"))
             (buffer-string)))))

(defvar site-attachments
  (regexp-opt '("jpg" "jpeg" "gif" "png" "svg"
                "ico" "cur" "css" "js" "woff" "html" "pdf"))
  "File types that are published as static files.")

(setq org-publish-project-alist
      (list
       (list "site-org"
             :base-directory "posts/"
             :base-extension "org"
             :recursive t
             :publishing-function '(org-html-publish-to-html)
             :publishing-directory "./public"
             :exclude (regexp-opt '("README" "draft"))
             :section-numbers nil
             :with-toc nil
             :html-preamble t
             :html-preamble-format (include-html 'header)
             :html-postamble t
             :html-postamble-format (include-html 'footer)
             :html-head-include-scripts nil
             :html-head-include-default-style nil
             :auto-sitemap t
             :sitemap-title "Blog Posts"
             :sitemap-filename "index.org"
             :sitemap-file-entry-format "%d *%t*"
             :html-head-extra "<link rel=\"stylesheet\" type=\"text/css\" href=\"/org-test-site/css/main.css\"/><link rel=\"icon\" type=\"image/x-icon\" href=\"/org-test-site/favicon.ico\"/>"
             :sitemap-style 'list
             :sitemap-sort-files 'anti-chronologically)
       (list "site-static"
             :base-directory "static/"
             :exclude "public/"
             :base-extension site-attachments
             :publishing-directory "./public"
             :publishing-function 'org-publish-attachment
             :recursive t)
       (list "site-rss"
             :base-directory "posts/"
             :base-extension "org"
             :include '("../index.org")
             :exclude "."
             :section-numbers nil
             :with-toc nil
             :publishing-directory "./public"
             :publishing-function '(org-rss-publish-to-rss)
             :recursive t)
       (list "site" :components '("site-org" "site-static" "site-rss"))))

(provide 'publish)
;;; publish.el ends here
