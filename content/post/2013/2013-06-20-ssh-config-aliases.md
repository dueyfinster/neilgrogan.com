---
date: "2013-06-20T00:00:00Z"
slug: ssh-config
tags:
- terminal
- linux
- secure-shell
title: SSH Config Aliases
---

If your like me and you deal with a lot of servers for development or test and do it from a Unix machine, I've got a really handy tip: SSH hostname pattern matching.

Say I've got a SSH config file like this (at `~/.ssh/config` ):

    host s*
        HostName atrcu%h.example.com
        User example1
        Port 22
    host b*
        HostName atrcx%h.example.com
        User example2
        Port 22
    host ??*
        HostName atvts%h.example.com
        User example5
        Port 2205

The ssh man page explains this really well:

>A pattern consists of zero or more non-whitespace characters, '*' (a
     wildcard that matches zero or more characters), or '?' (a wildcard that
     matches exactly one character).  For example, to specify a set of decla-
     rations for any host in the .co.uk set of domains, the following pat-
     tern could be used:

>	Host *.co.uk

> The following pattern would match any host in the 192.168.0.[0-9] network
     range:

>	Host 192.168.0.? 

>A pattern-list is a comma-separated list of patterns.  Patterns within
     pattern-lists may be negated by preceding them with an exclamation mark
     ('!').  For example, to allow a key to be used from anywhere within an
     organisation except from the ``dialup'' pool, the following entry (in
     authorized_keys) could be used:
     
>	from="!*.dialup.example.com,*.example.com"


So there you have it!