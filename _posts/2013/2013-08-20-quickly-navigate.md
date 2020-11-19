---
date: '2013-08-20'
description: Stop spending so much time remembering directory names with this tip
layout: post
link: http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
slug: navigate-fs
tags:
- terminal
title: Quickly navigate your filesystem
---

The article is a great tip for those who spend a good chunk of the working day on the command line. I made some adjustments to Bash completion code to get it to work on Mac OS X:

Original:

{% highlight bash %}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark
{% endhighlight %}

My modified version (tested on Mac OS X and Ubuntu):

{% highlight bash %}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}

  local wordlist=(`find $MARKPATH -type l | cut -d / -f 5`)

  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark
{% endhighlight %}