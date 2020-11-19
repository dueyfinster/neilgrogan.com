---
date: '2012-02-01'
layout: post
slug: very-simple-java-twitter-bot-twitter4j
tags:
- java
- programming
- code
title: Very Simple Java Twitter Bot (Twitter4J)
---

Below is code for the start of a Twitter bot I am going to build in Java. 
It's the most basic way of getting Oauth working (with any account, not 
just your developer account) and it shows your timeline and can update 
your status - that's it for now. The neat thing is it uses Java's awesome 
serialisation, so you only should have to authorise your twitter account once!

### What you will need:

-   Twitter4j Libraries
-   Oauth Consumer and Secret Key off twitter
-   **That is it!**


<script src="https://gist.github.com/2469810.js"> </script>

### What the code does:

1.  **Once only:**
    1.  Gives the user an url to visit
    2.  User enters a PIN provided by Twitter back in to the program
    3.  The program gets the proper keys for the account from Twittter
        and *saves them as a file*

2.  Everytime the program is restarted it reloads in account details (if
    the user gave permissions in steps above - it is not redone)
3.  User is provided with a Menu and either can update status or show
    timeline

I started off with[this code example][], so much props to [Twitter4J][]
team for a great library!

  [this code example]: http://twitter4j.org/en/code-examples.html#oauth
    "Twitter4J OAuth Example"
  [Twitter4J]: http://twitter4j.org/ "Twitter4J"