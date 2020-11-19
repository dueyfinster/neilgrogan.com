---
date: '2020-05-22'
image: /img/20/ubntsonos.png
layout: post
slug: ubnt-sonos
tags:
- networking,
- homenet
title: Ubiquiti Unifi with Sonos on a separate VLAN
---

Further to getting my [Unifi](/ubnt) gear last year, I've started to organise 
the virtual local area networks (VLANs) to increase security. I've created a 
separate guest wifi network and a separate internet of things (IoT) network. 
One issue you'll run in to is that a lot of modern devices work by broadcasting 
their presence on the network and that doesn't work well normally across VLANs. 
None more so than Sonos, the home wireless speaker solution. Fortunately through 
trial and error with the help of [Ubiquiti Forums][] - I've found a way to make it 
work.


First we need to switch off optimise network in settings:
![Optimize Network settings](/img/20/optimize.png "Optimise Network Settings")


Then in our network settings turn on IGMP snooping:
![IGMP Snooping settings](/img/20/igmpsnoop.png "IGMP Settings")

Then we need to set up IGMP proxy on our Ubiquiti Security Gateway (USG). 
Log in (password you can check on Cloud Key, `192.168.1.1` should be your USG's IP 
address):
```sh
$ ssh admin@192.168.1.1
```

Then on the USG console, we'll set upstream (our network with sonos controllers 
[for ex. iPhone, not on VLAN for me]) and downstream for the network with the Sonos hardware 
(for me VLAN `20` Play:1, Play:3 etc. etc.).
```sh
$ configure
$ edit protocols igmp-proxy
$ set interface eth1 role upstream
$ set interface eth1 threshold 1
$ set interface eth1.20 role downstream
$ set interface eth1.20 threshold 1
```

The configuration can now be show with (also enter these commands on USG):
```sh
$ show
```

and should look like this (obviously `20` VLAN should reflect which VLAN your speakers 
are in!):
```json
interface eth1 {
     role upstream
     threshold 1
 }
 interface eth1.20 {
     role downstream
     threshold 1
 }
```

If that's all OK we should save and commit (which will restart the IGMP proxy):
```sh
$ commit;save;exit
```

Then we can test our controllers work and can contact the speakers. If that works 
great! But now we need to add the configuration to our Cloud Key, since the next 
time the Unifi Security Gateway is provisioned, our configuration will be erased. 
Also, there is currently no graphical options for IGMP proxy on the Cloud Key, so 
we'll need to use a custom [config.gateway.json][]. We can dump our current configuration 
on our USG:
```sh
$ mca-ctrl -t dump-cfg > config.gateway.json
```

then we need to edit it using vim to only contain our igmp section:
```sh
$ vim config.gateway.json
$ # Remove all the config except our IGMP proxy
```

it should look like this, after you've finished editing it:
```json
{
        "protocols": {
                "igmp-proxy": {
                        "interface": {
                                "eth1": {
                                        "role": "upstream",
                                        "threshold": "1"
                                },
                                "eth1.20": {
                                        "role": "downstream",
                                        "threshold": "1"
                                }
                        }
                }
        }
}

```

if unsure, use [jsonlint.com](https://jsonlint.com) to double check syntax:
```sh
$ cat  config.gateway.json
$ # Copy nand paste in to JSONlint to check
```

Once we are happy our configuration is valid, let's copy it to our Cloud Key 
(replace `192.168.1.2` with your Cloud Key's IP address, password is your unifi 
account password with root user, check the [unifi config path][]):
```sh
$ scp config.gateway.json root@192.168.1.2:/usr/lib/unifi/data/sites/default/config.gateway.json
```

Then run a force provision on the USG from the Cloud Key web interface and then 
check the config remains intact (replace `192.168.1.1` with your USG's IP address):
```sh
$ ssh admin@192.168.1.1
$ configure
$ edit protocols igmp-proxy
$ show
```

and should again look like this:
```json
interface eth1 {
     role upstream
     threshold 1
 }
 interface eth1.20 {
     role downstream
     threshold 1
 }
```

Congratulations! It works! Next step is to enable firewall rules to drop traffic you don't 
want crossing the VLANs to make them more secure. Check [Sonos ports][] for examples on 
what to allow.

## What if it doesn't work?

If it's not working, try these steps:
1. Check IP addresses of Sonos products (have they taken IP addresses in new VLAN?)
2. Log on to the Cloud Key and try restart the IGMP proxy (forum reports of it 
crashing frequently on some people)
```sh
$ ssh admin@192.168.1.1
$ configure
$ edit protocols igmp-proxy
$ show
```
3. Try add a firewall rule (LAN IN) on the Cloud Key (which will provision to USG) to block all traffic from your VLAN 
to the other LAN/VLAN and turn logging on, can then check logs to see what traffic is 
allowed or denied on the USG:
```sh
$ ssh admin@192.168.1.1
$ cat /var/log/meesages | grep LAN_IN-
```
this gives an idea of what device is trying to talk to what on what port.

[Ubiquiti Forums]: https://community.ui.com/questions/Configure-Sonos-across-subnets-on-USG/a758382b-72e4-446b-90cc-ea353482ff1a
[config.gateway.json]: https://help.ui.com/hc/en-us/articles/215458888-UniFi-USG-Advanced-Configuration-Using-config-gateway-json
[unifi config path]: https://help.ui.com/hc/en-us/articles/115004872967
[Sonos ports]: https://support.sonos.com/s/article/688?language=en_US