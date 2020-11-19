;;; org-blog.el --- Blog with ox-publish          -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Narendra Joshi

;; Author: Narendra Joshi <narendraj9@gmail.com>
;; Keywords:

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

;; Org project configuration my personal blog.

;;; Code:
(package-initialize)
(require 'org)
(require 'ox-publish)
(require 'ox-html)
(require 'org-element)
(require 'ox-rss)
(require 's)

(defvar org-blog-date-format "%h %d, %Y"
  "Format for displaying publish dates.")

(defun org-blog-prepare (project-plist)
  "With help from `https://github.com/howardabrams/dot-files'.
  Touch `index.org' to rebuilt it.
  Argument `PROJECT-PLIST' contains information about the current project."
  (let* ((base-directory (plist-get project-plist :base-directory))
         (buffer (find-file-noselect (expand-file-name "index.org" base-directory) t)))
    (with-current-buffer buffer
      (set-buffer-modified-p t)
      (save-buffer 0))
    (kill-buffer buffer)))

(defvar org-blog-head
  "<link rel=\"stylesheet\" type=\"text/css\" href=\"/assets/css/main.css\"/>
  <link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"favicon.ico\">")

(defun org-blog-preamble (plist)
  "Pre-amble for whole blog."
  ;; Hack! Put date for the post as the subtitle
  (when (s-contains-p "/posts/" (plist-get plist :input-file))
    (plist-put plist
               :subtitle (format "Published on %s"
                                 (org-export-get-date plist
                                                      org-blog-date-format))))
  ;; Return a simple banner with navigation links
  "")

(defun org-blog-postamble (plist)
  "Post-amble for whole blog."
  (concat
   "</div></div>
<footer class=\"site-footer\">

  <div class=\"wrapper\">
    <div class=\"footer-col-wrapper\">
      <div class=\"footer-col footer-col-1\">
        <p>
          <a href=\"https://www.neilgrogan.com\">
            <img src=\"https://www.gravatar.com/avatar/7d4e90054191caa873d6654d0efe22b5.png?s=100\" alt=\"Neil Grogan\">
          </a>
        </p>
        
        <ul class=\"contact-list\">
          <li>Neil Grogan</li>
          <li><a href=\"mailto:neil@grogan.ie\">neil@grogan.ie</a></li>
        </ul>
      </div>

      <div class=\"footer-col footer-col-2\">
        <ul class=\"social-media-list\">
          
          <li>
            <a href=\"https://github.com/dueyfinster\"><span class=\"icon icon--github\"><svg viewBox=\"0 0 16 16\"><path fill=\"#828282\" d=\"M7.999,0.431c-4.285,0-7.76,3.474-7.76,7.761 c0,3.428,2.223,6.337,5.307,7.363c0.388,0.071,0.53-0.168,0.53-0.374c0-0.184-0.007-0.672-0.01-1.32 c-2.159,0.469-2.614-1.04-2.614-1.04c-0.353-0.896-0.862-1.135-0.862-1.135c-0.705-0.481,0.053-0.472,0.053-0.472 c0.779,0.055,1.189,0.8,1.189,0.8c0.692,1.186,1.816,0.843,2.258,0.645c0.071-0.502,0.271-0.843,0.493-1.037 C4.86,11.425,3.049,10.76,3.049,7.786c0-0.847,0.302-1.54,0.799-2.082C3.768,5.507,3.501,4.718,3.924,3.65 c0,0,0.652-0.209,2.134,0.796C6.677,4.273,7.34,4.187,8,4.184c0.659,0.003,1.323,0.089,1.943,0.261 c1.482-1.004,2.132-0.796,2.132-0.796c0.423,1.068,0.157,1.857,0.077,2.054c0.497,0.542,0.798,1.235,0.798,2.082 c0,2.981-1.814,3.637-3.543,3.829c0.279,0.24,0.527,0.713,0.527,1.437c0,1.037-0.01,1.874-0.01,2.129 c0,0.208,0.14,0.449,0.534,0.373c3.081-1.028,5.302-3.935,5.302-7.362C15.76,3.906,12.285,0.431,7.999,0.431z\"></path></svg>
</span><span class=\"username\">dueyfinster</span></a>

          </li>
          

          
          <li>
            <a href=\"https://twitter.com/dueyfinster\"><span class=\"icon icon--twitter\"><svg viewBox=\"0 0 16 16\"><path fill=\"#828282\" d=\"M15.969,3.058c-0.586,0.26-1.217,0.436-1.878,0.515c0.675-0.405,1.194-1.045,1.438-1.809c-0.632,0.375-1.332,0.647-2.076,0.793c-0.596-0.636-1.446-1.033-2.387-1.033c-1.806,0-3.27,1.464-3.27,3.27 c0,0.256,0.029,0.506,0.085,0.745C5.163,5.404,2.753,4.102,1.14,2.124C0.859,2.607,0.698,3.168,0.698,3.767 c0,1.134,0.577,2.135,1.455,2.722C1.616,6.472,1.112,6.325,0.671,6.08c0,0.014,0,0.027,0,0.041c0,1.584,1.127,2.906,2.623,3.206 C3.02,9.402,2.731,9.442,2.433,9.442c-0.211,0-0.416-0.021-0.615-0.059c0.416,1.299,1.624,2.245,3.055,2.271 c-1.119,0.877-2.529,1.4-4.061,1.4c-0.264,0-0.524-0.015-0.78-0.046c1.447,0.928,3.166,1.469,5.013,1.469 c6.015,0,9.304-4.983,9.304-9.304c0-0.142-0.003-0.283-0.009-0.423C14.976,4.29,15.531,3.714,15.969,3.058z\"></path></svg>
</span><span class=\"username\">dueyfinster</span></a>

          </li>
          
        </ul>
      </div>

      <div class=\"footer-col footer-col-3\">
        <p>Neil is a Software Developer from Ireland. He blogs occasionally here!
</p>
      </div>
    </div>

  </div>

</footer>"

   ;; Add Disqus if it's a post
   (when (s-contains-p "/posts/" (plist-get plist :input-file))
     " ")))


(defun org-blog-sitemap-format-entry (entry _style project)
  "Return string for each ENTRY in PROJECT."
  (when (s-starts-with-p "posts/" entry)
    (format "@@html:<span class=\"archive-item\"><span class=\"archive-date\">@@ %s @@html:</span>@@ [[file:%s][%s]] @@html:</span>@@"
            (format-time-string org-blog-date-format
                                (org-publish-find-date entry project))
            entry
            (org-publish-find-title entry project))))

(defun org-blog-sitemap-function (title list)
  "Return sitemap using TITLE and LIST returned by `org-blog-sitemap-format-entry'."
  (concat "#+TITLE: " title "\n\n"
          "\n#+begin_archive\n"
          (mapconcat (lambda (li)
                       (format "@@html:<li>@@ %s @@html:</li>@@" (car li)))
                     (seq-filter #'car (cdr list))
                     "\n")
          "\n#+end_archive\n"))

(defun org-blog-publish-to-html (plist filename pub-dir)
  "Same as `org-html-publish-to-html' but modifies html before finishing."
  (let ((file-path (org-html-publish-to-html plist filename pub-dir)))
    (save-window-excursion
      (with-current-buffer (find-file-noselect file-path)
        (goto-char (point-min))
        (search-forward "<body>")
        (insert (concat "<header class=\"site-header\">

  <div class=\"wrapper\">

    <a class=\"site-title\" href=\"/\">Neil Grogan</a>

    <nav class=\"site-nav\">
      <a href=\"#\" class=\"menu-icon\">
        <svg viewBox=\"0 0 18 15\">
          <path fill=\"#424242\" d=\"M18,1.484c0,0.82-0.665,1.484-1.484,1.484H1.484C0.665,2.969,0,2.304,0,1.484l0,0C0,0.665,0.665,0,1.484,0 h15.031C17.335,0,18,0.665,18,1.484L18,1.484z\"></path>
          <path fill=\"#424242\" d=\"M18,7.516C18,8.335,17.335,9,16.516,9H1.484C0.665,9,0,8.335,0,7.516l0,0c0-0.82,0.665-1.484,1.484-1.484 h15.031C17.335,6.031,18,6.696,18,7.516L18,7.516z\"></path>
          <path fill=\"#424242\" d=\"M18,13.516C18,14.335,17.335,15,16.516,15H1.484C0.665,15,0,14.335,0,13.516l0,0 c0-0.82,0.665-1.484,1.484-1.484h15.031C17.335,12.031,18,12.696,18,13.516L18,13.516z\"></path>
        </svg>
      </a>

      <div class=\"trigger\">
          <a class=\"page-link\" href=\"/presentations/\">Presentations</a>
          <a class=\"page-link\" href=\"/about/\">About</a>
          <a class=\"page-link\" href=\"/projects/\">Projects</a>
      </div>
    </nav>
  </div>
</header>\n<div class=\"page-content\"><div class=\"wrapper\">\n"))
        (goto-char (point-max))
        (search-backward "</body>")
        ;;(insert "\n</div>\n<div class=\"col\"></div></div>\n</div>\n")
        (save-buffer)
        (kill-buffer)))
    file-path))


(setq org-publish-project-alist
      `(("orgfiles"
         :base-directory "~/repos/org-blog/src/"
         :exclude ".*drafts/.*"
         :base-extension "org"

         :publishing-directory "~/repos/org-blog/"

         :recursive t
         :preparation-function org-blog-prepare
         :publishing-function org-blog-publish-to-html

         :with-toc nil
         :with-title t
         :with-date t
         :section-numbers nil
         :html-doctype "html5"
         :html-html5-fancy t
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :htmlized-source t
         :html-head-extra ,org-blog-head
         :html-preamble org-blog-preamble
         :html-postamble org-blog-postamble

         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "Blog Posts"
         :sitemap-style list
         :sitemap-sort-files anti-chronologically
         :sitemap-format-entry org-blog-sitemap-format-entry
         :sitemap-function org-blog-sitemap-function)

        ("assets"
         :base-directory "~/repos/org-blog/src/assets/"
         :base-extension ".*"
         :publishing-directory "~/repos/org-blog/assets/"
         :publishing-function org-publish-attachment
         :recursive t)

        ("rss"
         :base-directory "~/repos/org-blog/src/"
         :base-extension "org"
         :html-link-home "https://www.neilgrogan.com/"
         :html-link-use-abs-url t
         :rss-extension "xml"
         :publishing-directory "~/repos/org-blog/"
         :publishing-function (org-rss-publish-to-rss)
         :exclude ".*"
         :include ("index.org")
         :section-numbers nil
         :table-of-contents nil)

        ("blog" :components ("orgfiles" "assets" "rss"))))

(provide 'org-blog)
;;; org-blog.el ends here
