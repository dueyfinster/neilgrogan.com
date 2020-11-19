---
date: '2016-11-30'
layout: post
slug: ssh-login-cmd
tags:
- terminal
- secure-shell
title: Run Command on SSH Login
---

Do you need to run a command on SSH login? There are a lot of solutions on the web for this, but most of them are very complex. I stumbled across this easy method of using the ``authorized_keys`` file, simply add ``command="ls -l"`` (replacing ``ls -l`` with something a bit more useful like ``tmux`` or ``screen``) in front of the key fingerprint. This also means you can have different commands for different keys if you choose.

Example ``authorized_keys`` file:
```
command="tmux a -t <mysessionname>" ssh-rsa AAAAB3...
```
A lot of the other solutions you'll find on the web recommend editing profile, bashrc, ssh_config or some other important shell files - something you should avoid unless absolutely necessary. One more word of advice, make sure the command _will always execute sucessfully_. If the command fails _for any reason_ (like a Tmux session not existing) your SSH connection will close, since this is the command that will keep it open. That's fine if you have access to the computer and have a screen attached to fix it, but if you are remote then you will be out of luck.

If you enjoyed this post, you should check out my post on [using patterns in SSH config file](/ssh-config).