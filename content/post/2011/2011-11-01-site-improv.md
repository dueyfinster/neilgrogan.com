---
date: '2011-11-01T00:00:00Z'
slug: site-improv
tags:
  - software
title: Website Improvements
---

I haven't been posting much lately because I have been working hard to improve
the experience of visiting this website. You may ask _what does that mean?_ -
well it is simple. I love going to websites that are uncluttered, provide useful
information and are to the point. It's also small things like having a really
fast page load time. So here's a flavour of some of what I have been working on
lately...

## Navigation improvements

- Brand new menu, which can hold nested menus, images and more (much more
  flexible).
- Proper [Sitemap][], [Atom][] and [RSS][] feeds
- Accessibility keys can now be used to navigate to every page on the menu (for
  screen readers)

## Speed improvements

- Blockquotes are now 100%
  <acronym title="Cascading Style Sheets">CSS</acronym> - no images. Other post
  elements will follow when CSS3 allows.
- I am in the process of downsizing all images to thumbnail size (as a bonus if
  you click on it you'll get beautiful full size image goodness)

## Maintainability Improvements

- All posts are now written in Markdown, which is like plain text. Makes me
  updating old posts with bad info way easier.
- The history of every page [in the repository][repo] and can be referenced and
  restored (indeed I use it to constantly roll out and back
  changes/improvements).
- Permalinks will be provided at the end of each page. Posts can be safely
  linked to now and should always work.
- I've started adopting [Microformats][] around the site as a way to feed search
  engines and crawlers more useful information on both myself and the websites
  content
- Similiar to Microformats, I've marked up posts so services such as
  [Readability][] and [Instapaper][] should have no trouble parsing out all the
  stuff they don't need (such as site navigation, comments etc.)
- Images are getting or will have alternative tags for the visually impaired.

**and more to come...**

There is still going to be a lot of broken posts for various reasons - I am
doing my best to review and update as many as I can. Unfortunately changing
blogging platform and having 150+ posts (since 2004) doesn't make updates easy,
but once things are fixed I'll have a better idea of how to avoid such mess in
future. Do [contact me][] if you see any I have missed!

[Sitemap]: /sitemap.xml "Neil Grogan's Sitemap"
[Atom]: /atom.xml "Neil Grogan's Atom Feed"
[RSS]: /rss.xml "Neil Grogan's RSS Feed"
[repo]: https://github.com/dueyfinster/dueyfinster.github.com 'My Github Repo'
[Microformats]: http://microformats.org/ 'Microformats'
[Readability]: http://www.readability.com/ 'Readability'
[Instapaper]: http://www.instapaper.com/ 'Instapaper'
[contact me]: /contact/
