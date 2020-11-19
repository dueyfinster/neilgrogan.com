---
date: '2011-02-09'
layout: post
slug: thoughts-on-ipv6
tags:
- networking
title: Thoughts on IPv6
---

A multitude of websites have been reporting the impending doom 
of ipv4 exhaustion, which is going to happen soon. All the top 
level address' will be gone, but the regional registries will 
still have stocks of address' in to 2011. As a user of ipv6, I 
thought I could share sone thoughts/insights on the events ahead...

Below is a very good video which one of my favourite tech shows, 
[Hak5][HK] made with an IPv6 Consultant, Joe Klein.

<iframe width="560" height="315" src="http://www.youtube.com/embed/cl4cEbPayek" frameborder="0" allowfullscreen></iframe>

My own experience has been straightforward on the set up side 
of things. We had to purchase an Apple Airport Extreme router 
however, which is the biggest pain in the transition, the **cost.** 
Most home routers do not have proper IPv6 capability, a serious 
problem. This will cost the Internet Service providers a lot of 
money in keeping these old routers *shielded* from the ever 
increasing IPv6 enabled websites and services - to the point at 
which a large scale upgrade may well be cheaper, but this is not 
likely to happen in the short term.


## Setup of IPv6
<a href="http://farm3.static.flickr.com/2072/2261404319_51bbec44ab.jpg" title="Data centers will be one of the first to be all IPv6. (Photo credit: dbarsky)"><img src="/files/2011/02/datacenter.jpg" class="right" alt="Data Center LAN Cabling"/></a>
The funny thing with IPv6 is that machines self issue address' and 
can use them locally if you have an IPv6 capable router, defaulting 
to IPv4 when going through your NAT to the Internet. So it's the 
bridge to your ISP is the issue. Where I set it up, my ISP is 
small and has no IPv6 support. I emailed them about it, to get 
no response. It's probably worth trying again since most ISP's 
are running trials now, and you may get a router upgrade if you 
opt-in now. So I had to set up a tunnel, using the excellent 
[Hurricane Electric][HE]. My ISP is slow though (average 
1mbps rural wireless) and when the tunnel is set up **all 
traffic defaults to IPv6**, it makes it even slower. 
*Tunnels are not ideal* because the result will always depend 
on the quality of connection to your tunnel provider and the 
overhead that provides. Since IPv6 packets are bigger than IPv4 
packets, your going to get a lot more IPv4 packets for the same 
volume of traffic, the major downside of tunneling. Tunnels are 
good to get some IPv6 experience, but not much else unless you 
have a very fast connection. The transition itself will probably 
look like this:

* Tunnels are set up, small contained IPv6 networks exist (**already happend**)
* IPv6 islands merge, major ISP's peer and inter-network communication switches to IPv6 (**happening now**)
* ISP's start to use 4to6 tunnels to get to the IPv6 part of the Internet
* ISP's switch equipment and use 6to4 tunnels to get to ever decreasing IPv4 Internet
* Like Usenet, ISPs state there is no demand for IPv4, and drop it to be fully native IPv6

So I'd advise anyone right now who has the patience and the interest to 
invest time in IPv6, it's a game-changing technology, not necessarily 
better but a must to have knowledge of. As I mentioned earlier Hurricane 
Electric provide [free tunnels][tunnel] (you can even set it up on a 
single computer if your router can't support IPv6) and [free certification][cert] 
to test these skills.

[HK]: http://hak5.org/
[HE]: http://he.net/
[tunnel]: http://tunnelbroker.net/
[cert]: http://ipv6.he.net/certification