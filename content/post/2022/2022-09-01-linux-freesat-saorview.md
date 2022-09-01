---
date: "2022-09-01T00:00:00Z"
slug: linux-freesat-saorview
tags:
- linux
- diy
title: Linux, Freesat and Saorview
---

I recently replaced a rusty satellite dish and faulty LNB (it has been in use in the house I moved in to for 10+ years I'd guess) and decided to try install one myself. Here in Ireland, the two main broadcast methods of receiving TV are satellite ([Freesat][] / [Sky][]) and terrestrial aerial ([Saorview][]).

An issue I have one larger sitting room TV and one small living room TV. I couldn't get both to be Samsung (out of stock on smallest sizes - which seem to be going out of fashion). So both TVs had very different methods of switching between satellite and aerial connections. I'm not sure if it is a hardware limitation (they make switching tuners slow to hide this), a licensing issue (broadcasters pay to be on the [Freesat][] EPG for example) or a software issue (seems least likely). The fact multiple TV brands (in my case Phillips/Samsung) make it this clunky - makes me think it's a licensing issue. I wanted to solve this by using an external box and having one mental model for navigating broadcast TV.

As I was busy researching the parts I need to fix the satellite - I thought I would look to address the issue of having one set of channels with a 7 day programme guide for Saorview and Freesat. I came across a thread on [Boards.ie][] suggesting a Linux-based reciever box that is made in China: the Zgemma H7S. The specs on this reciever are good: 4K resolution, 2 Satellite Tuners and one terrestrial/cable tuner. Having two tuners of the same type is key here: it allows you to record and watch any channel at the same time. The operating system being Linux and that by nature being very easy to modify are a bonus ! Also you have a choice of which distribution you want to use (I got [OpenViX][] pre-installed on mine) which leads to lots of choices in plugins and skins (how you want it to look).

One excellent feature is the ability to stream from this box, and use [OpenWebif][] to configure the "bouquets" (groups of channels like News/Sport etc) or simply change the channels from your phone with the excellent [tellymote][]. It can grab the bouquets from [Sky][]/[Freesat][] and the interface is very similar to Sky. It's definitely not as seamless - you need to configure some plugins to update the 7-day Electronic Programme Guide (EPG) for example and every so often channels do move and rename themselves (so you should edit them in OpenWebIf to change/remove them from EPG). But overall I'm very happy with this solution!



[LNB]: https://en.wikipedia.org/wiki/Low-noise_block_downconverter
[Freesat]: https://www.freesat.co.uk/
[Sky]: https://www.sky.com/ie/
[Saorview]: https://www.saorview.ie/
[enigma2]: https://www.enigma2.net/
[boards.ie]: https://www.boards.ie
[OpenViX]: https://www.openvix.co.uk/
[OpenWebif]: https://github.com/E2OpenPlugins/e2openplugin-OpenWebif
[tellymote]: https://apps.apple.com/ie/app/telly-mote/id813137455
