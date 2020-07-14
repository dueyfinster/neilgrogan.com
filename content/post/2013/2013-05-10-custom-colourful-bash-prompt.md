---
date: "2013-05-10T00:00:00Z"
slug: colour-bash
tags:
- bash
- linux
- terminal
title: Custom Colourful Bash Prompt
---

Bash, a command line shell is one of the most used pieces of software in my daily work. I like scripting repetitive actions to save a lot time (it brings me great joy!). One of the simplest and easiest customisations is to add a bit of colour to your otherwise boring bash prompt (otherwise known as $PS1):

    [ngrogan@localhost:~]$

can be turned in to this:

<img src="/files/2013/05/ColourBashPrompt.png" alt="My Custom Colour Bash Prompt">

The thing about Bash is the colour codes to achieve this can look archaic:

{{< highlight bash >}}

    export PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\[$(tput setaf 6)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 2)\]\h\[$(tput setaf 7)\]:\[$(tput setaf 1)\]\W\[$(tput setaf 4)\]]\\$ \[$(tput sgr0)\]"

{{< / highlight >}}

To get a prompt like this easily, all you need to do is use this handy $PS1 generator. A highly recommended tool!