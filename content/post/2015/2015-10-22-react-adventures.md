---
date: "2015-10-22T00:00:00Z"
slug: react
tags:
- javascript
- programming
title: Adventures with React
---

Recently I'd seen a post on [Hacker News][hn] about a [course for the React JavaScript Framework][course]. I haven't done much with JavaScript, apart from a course in work, which was focused on the language itself and [jQuery][jq]. [React][] is a front end framework, which allows you to build reusable components (and generate them with data.)

The only real experience I have is writing an application (using [Node.js][node]) for [my MSc course][msc] which was an [AJAX][] application for interacting with [Amazon SimpleDB][amsdb]. It was fun to write and weird that I could use the same language from the front-end to the back-end. 

Back to the React course, I completed it over a week, taking my time to break things (it's the only way to get an appreciation for how things work!). It's a really nicely laid out course, where you build a market for fish (a lot more exciting then it sounds). It doesn't really cover any [CSS][] or [HTML][], so you should at least know that before starting.

What I really liked in particular was the build tools, including [Gulp][]. Gulp is like Make, Maven, Gradle, Ant etc. It's very flexible and fast, with hundreds of modules on [Node Package Manager][NPM] to choose from. Part of building the app, you can make the assets ([HTML][]+[CSS][] etc) smaller ([minification][mini]), run a web server and open your browser with the app automatically. Combined with a nifty tool called [BrowserSync][bsync], it's the fastest feedback cycle I've probably ever had. That makes it fantastic if your new to this kind of thing, nothing inspires happiness more than seeing instant results!

Also the course does a pretty good job at taking you from today's JavaScript standard ([ES5][]) to the more modern equivalents ([ES6][], [ES7][]). JavaScript in time is set to become a much nicer language to write, the only problem is compatibility. Luckily the course touches on [Babel][] which happily [transpiles][] all your fancy newer JavaScript down the widely supported standard of [ES5][]. The compatibility will probably be painful, it always is - judging by Python (2 to 3), Perl and all the other languages which have sought to remove cruft.

All in all I'd very much recommend it. I even re-wrote [Grogan Burners][gbs] (My Fathers business) website to use React components after! 

[hn]: https://news.ycombinator.com/item?id=10499683
[AJAX]: http://www.w3schools.com/ajax/default.asp
[course]: https://reactforbeginners.com/
[jq]: http://jquery.com/
[msc]: /ucd 
[React]: https://facebook.github.io/react/
[node]: http://nodejs.org/
[amsdb]: https://en.wikipedia.org/wiki/Amazon_SimpleDB
[NPM]: https://www.npmjs.com/
[CSS]: http://www.w3schools.com/css/
[HTML]: http://www.w3schools.com/html/default.asp
[babel]: https://babeljs.io/
[transpiles]: https://en.m.wikipedia.org/wiki/Transpile
[ES5]: https://es5.github.io/
[ES6]: http://www.es6js.com/
[ES7]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/New_in_JavaScript/ECMAScript_7_support_in_Mozilla
[mini]: https://en.wikipedia.org/wiki/Minification_(programming)
[gbs]: http://www.grognburners.ie
[gulp]: http://gulpjs.com/
[bsync]: http://www.browsersync.io/