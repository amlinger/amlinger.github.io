---
layout: post
title:  "Who is Home on an Asus Router"
date:   2017-05-14 10:00:00 +0100
categories: HomeAutomation
---
I like knowing whats on my local network. Sharing a house with a bunch of roommates, the idea was that knowing who and what is connected to the WiFi/Ethernet on the router could help automating this, and building cool services on top of.

The first approach I took was using a NodeJs server (because everything needs to be written in JavaScript these days) using [Nmap](https://nmap.org/) to scan the network for IP addresses, together with (ARP)[https://en.wikipedia.org/wiki/Address_Resolution_Protocol] to resolve MAC addresses from the IP's that Nmap provided. Running this server on a RaspberryPi was pretty unreliable, finding all hostnames, as well as resolving the IP addresses was shaky at best.

### Finding a Way In

I came upon this idea back in February, and did not pursue it any further for reasons stated above, and didn't think much about it until a few weeks ago, when I stumbled upon this article from [My Cyber Universe](http://mycyberuniverse.com/linux/full-controling-the-asus-router-via-command-line.html), which describes how to gain Telnet access to your Asus Router. Given that I'm the owner of an Asus RT-N66U, I proceeded to automating the task of looking up which devices are present in the Routers, much more reliable, ARP table, and presenting that on the local network via (of course) a NodeJs server.

### Solution

The work the server does is minimal. On a given interval, a script on the server Telnets into the Asus router, and reads the ARP table file. This is then parsed and stored locally. For each record without a name, `nslookup` is done to resolve the hostname via the DNS server running on the router.

Find the project here: https://github.com/amlinger/who-is-home

#### Points of improvement

The small project could benefit from a couple of small improvements, that is still upcoming:
1. Invalidate the local hostname cache. Even though the Hostname is unlikely to change for any of the devices on the network, restarting the server to get the new Hostname is cumbersome.
2. Lock management. The current solution is a concurrency-hazard, and reading and writing to the same mapping at the same time is bound to happen at some point. This could be addressed by adding mutex locks.
