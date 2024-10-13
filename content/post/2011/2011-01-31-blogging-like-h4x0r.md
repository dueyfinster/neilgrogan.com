---
date: '2011-01-31T00:00:00Z'
slug: blogging-like-h4x0r
tags:
  - ruby
title: Blogging like a H4x0r
---

Apologies to those visiting my site recently because:

- It hasn't been updated recently
- I have been changing hosts with it

Let me explain both of these! I have been searching for a good blogging engine
ever since I have started blogging. I have yet to find the perfect one :) Some
have come close in completeness ([WordPress][WP]) or price and ease of use
(blogger), but none has been all-encompassing. I messed around with a blogging
engine called [Jekyll][JK] about a year and a half ago, but I never ended up
deploying it. I had my website most recently on Google Sites, and the ease of
use was pretty good, but themes-wise it was pretty frustrating, also they force
an ugly footer on all pages, yuck.

There are a few reasons I have made the switch to Jekyll, mainly because I have
got the ultimate _cool_ factor in the setup of all this. I write all of my posts
in plaintext, like Notepad (for reference for Windows users out there). This
means in 100 years time they'll still be readable (if anyone so wishes to read
them). I've seen enough computer formats to know each one of them suck in some
way. Plain text just sucks that little bit less because it's been around since
the dawn of computer time (bar weird encoding, which is sorted now I hope with
UTF standard). It also simplifies my switch away from Jekyll, which I have
learned is the **most** important feature of any blogging platform. Jekyll takes
this text, combines it with some nice visual cruft you see all around the text
and makes it nicely readable. As it transfers it in to folders as html, **any**
web server software can serve this website. Making it plain html also makes it
**lightning** fast to load (since there is no PHP or other dynamic languages
being used).

So at this point your saying - okay? so what? Well the cool part is I use Git to
save all my hard work, making undo actions to this website (I would say
mistakes, but I don't make any :) ) extremely easy and fast! Also is the
coolness of Dropbox, my whole generated Jekyll site is synced to my server to be
displayed here as it's finished. So it's very, very fast in almost every respect
and it's backed up like crazy and I use my favourite text editor (in a terminal
shell if I need) to edit all this loveliness. I was partly inspired to do all of
this [by this blog post][MetaJack], which I'd seen back in 2009 when I was
researching Jekyll. Although the work in this system is in the setup, it is
super easy to use once set up. I can even create posts on my iPhone, using the
many apps which hook in to Dropbox to edit files stored there. If you ever
wanted to know, that's blogging like a h4x0r!

[WP]: http://wordpress.org/
[JK]: http://github.com/mojombo/jekyll
[MetaJack]: http://metajack.im/2009/01/23/blogging-with-git-emacs-and-jekyll/
