---
title: 'Kubernetes and Nix Cluster'
slug: k8s-nix-cluster
date: 2025-08-29
tags:
  - hardware
  - review
---

About this time last year, I purchased 3 mini computers with the aim of making a [Kubernetes](https://kubernetes.io/) cluster. I followed an excellent youtube video: [This homelab setup is my favorite one yet - Dreams of Autonomy](https://youtu.be/2yplBzPCghA?si=1Fq1Fx0PSvXP8krE) ([Github Repository](https://github.com/dreamsofautonomy/homelab)) which described the machines to buy (Beelink EQ 13 Mini), how to upgrade the <abbr title="Solid State Disk">SSD</abbr> and <abbr title="Random Access Memory">RAM</abbr>, how to provision them with [NixOS](https://nixos.org), setup [K3S](https://k3s.io), and connect using [kubectl](https://kubectl.docs.kubernetes.io/guides/) to manage the cluster. You will also have to modify your router's <abbr title="Dynamic Host Configuration Protocol">DHCP</abbr> settings so you can give the cluster static <abbr title="Internet Protocol">IP</abbr> addresses.



Things deployed on it (using [Helm](https://helm.sh)/[helmfile](../DevOps/helmfile.md) and [kustomize](../DevOps/kustomize.md)):

- [Longhorn](https://longhorn.io) - for storage
- [MetalLB](https://metallb.io) - for load-balancing and IP assignment 
- [Nginx](https://nginx.org) - as an ingress controller
- [Pihole](https://pi-hole.net) - for ad blocking and DNS service
- [externaldns](https://github.com/kubernetes-sigs/external-dns) - able to update Pihole DNS records when a new service is added

These are all in the Github repo linked above. I've since experimented with other services on the cluster such as:

- [Grafana](https://grafana.com) and [Prometheus](https://prometheus.io) - for dashboards and monitoring

- [Flux](https://fluxcd.io) - CI/CD deployment from config direct to the cluster

- [Livebook](https://livebook.dev) - for live coding, and interacting with services 

- [Redis](https://redis.io) - as a data store (maybe I should have use [Valkey](https://valkey.io)? )

- [Postgres](https://www.postgresql.org) - database

- [Kafka](https://kafka.apache.org) - message bus

- and more I'm currently trying..

  

### Things that have surprised me are: 

* There was a small configuration value missing from the video, which [I created a pull request to address](https://github.com/dreamsofautonomy/homelab/pull/1)
* the lack of readily available and easily usable Helm charts on [ArtifactHub](https://artifacthub.io) - Bitnami filled this role somewhat but [has converted to a commerical model](https://github.com/bitnami/charts/issues/35164), disappointingly 
* I tried to use <abbr title="Large Language Models">LLMs</abbr> to give me correct helm values but it always got confused (should it not be simple?)
* the sheer amount of YAML config
* Troubleshooting needs a defined workflow of what to check (but this is useful to practice)
* Nix running out of space on `/boot` while trying to upgrade the Linux kernel



### Things that worked well

* The hardware was very easy to use and upgrade
* Nix has been solid in upgrades (I expected things to break - only one was the `/boot` issue above)
* Using internal or external domains was easier than I thought, I've exposed some on `.lan` and some on a public domain
* kubectl is a nice tool, the information density is good
* Helmfile is a nice way to deploy
* Livebooks were brilliant to test other services, e.g. I wrote Elixir to interact with Postgres, Redis and other services on the cluster



### Would I do this again?

I'm happy I did this as it's been a great learning opportunity for me to break things and fix them again. Kubernetes can be a bit off-putting with concepts, how they are linked and how to just deploy something quickly to verify it works. There's a lot to understand before something works.

I really would only recommend using Kubernetes an Enterprise context where you have more than one workload. For simpler apps, I would stick to docker, docker-compose and things like Dokku. Or of course doing it just for fun, learning and experimenting!

