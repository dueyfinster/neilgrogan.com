---
date: '2011-02-05'
layout: post
slug: output-percentage-of-file-bash-code
tags:
- programming
- bash
- code
title: Output Percentage of File (Bash code)
---

I wrote this script recently for a friend in a job who 
needed to output a certain percentage of a log file, but 
no more and no less. This was in Linux using bash, so I 
had a go at writing a solution, which you see below. Posting 
this up in case it's useful to anyone else!

{% highlight bash %}
	# !/bin/sh
	# Public Domain, by Neil Grogan 2010
	# Script to output last 30% of file by lines

	OLDFILE=&quot;oldlog.txt&quot;
	NEWFILE="newlog.txt"
	PERCENT=0.7

	#Use wc to count lines
	LINES=$(wc -l $OLDFILE | awk '{ print $1}')

	#Linespercent = 2 decimal places, lines by percent, round to whole
	LINESPERCENT=$(echo "scale=2; $LINES*$PERCENT" | bc | xargs printf "%1.0f" )

	# Use tail to get last 30% and output, can use tail -s with sleep time to have it run on sched.
	tail -n $LINESPERCENT $OLDFILE >> $NEWFILE
{% endhighlight %}