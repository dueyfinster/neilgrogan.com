---
date: "2007-07-03T00:00:00Z"
slug: windows-vista-security-better-than
tags:
- windows
- linux
title: Windows Vista Security - Better than Linux?
---

After reading a [nice article written by Jeff
Jones](http://blogs.csoonline.com/node/218), a security researcher for
Microsoft. He says [he isn't
biased](http://blogs.csoonline.com/exactly_how_biased_am_i), saying he
worked over 75% of his career outside Microsoft, using Slackware Linux,
Unix, HP Unix etc. He claims Windows Vista has less security holes than
popular versions of Linux, such as Ubuntu (he also compares Red Hat,
Novell, Mac OS X). First let me say why his facts are distorted, and why
he knows his facts are distorted. His facts do raise an issue of slow
patching of vulnerabilities across the software Industry, but Linux
performs the best consistently because anyone can audit the code. Here's
why his comparisons are uneven:  
-   Linux is open source, so various tools can be used to find
    vulnerabilities. We don't have this luxury with Windows, any holes
    found are needles in a haystack, but the target of the Windows
    monopoly allows greater incentive to find these needles
-   Linux has used SUDO and ROOT users properly since its inception
    (Think of Administrator in Windows). Anyone who is not a root user
    on Linux cannot install programs, make system wide changes, and you
    can even stop them from using USB keys, CD Drives etc if you are
    paranoid. Now this has received much attention, Vista has
    retroactively inserted this kind of security, but by my experience,
    it is very obtrusive, and can be switched off. Root in Linux is alot
    harder to stop, and theres no graphical way to do it, so the average
    user won't.
-   A link to my second point above, Programs in Linux can only access
    what they need to, the home folder of the user that is running it
    and very little else. I don't know what the case is in Vista, but in
    Windows XP, almost any program could destroy your system, by picking
    at the much famed registry.

He provides pretty graphs, let me provide my
own:[![image](http://secunia.com/graph/?type=sol&period=all&prod=13223)](http://secunia.com/graph/?type=sol&period=all&prod=13223)  
[![image](http://secunia.com/graph/?type=sol&period=all&prod=14068)](http://secunia.com/graph/?type=sol&period=all&prod=14068)  
  
[![image](http://secunia.com/graph/?type=cri&period=all&prod=14068)](http://secunia.com/graph/?type=cri&period=all&prod=14068)  
[![image](http://secunia.com/graph/?type=cri&period=all&prod=13223)](http://secunia.com/graph/?type=cri&period=all&prod=13223)
  
  
(click on Graphs to Enlarge)  
As you can see, Ubuntu Linux 7.04 (released April) compares
comparatively better to Vista, available since January. The Graphs are
provided by Secunia, an independent security research firm. Microsoft
often downplays vulnerabilities other companies like Secunia find, which
is also a factor that Jeff Jones did not mention (maybe he forgot?). I
forget where this famous quote comes from but I have paraphrased: "You
cannot depend on a man understanding a problem if his salary depends on
him not understanding it", which I think affects Mr. Jeff Jones.