---
date: '2020-05-02'
layout: post
slug: vagrant-ubuntu-fossa
tags:
- networking,
- homenet
title: Ubuntu 20.04 Vagrant with Packer
---

Ubuntu have recently released the new [20.04 LTS codenamed "Focal Fossa"][fossa].
I'd also recently seen a tool that piqued my interest, Hashicorp [Packer][]. Packer 
builds machine images that can be deployed to a cloud or as a virtual machine, or 
just even a plain disk image. You can even generate many images at once, really 
simplfying deployment. Very handy if you wanted to create virtual machines for a 
cluster for example, with a similar but slightly different configuration.


I decided to take Packer for a spin and try create a virtual machine image for 
[Virtualbox][]/[Vagrant][] that can easily be spun up for any project. Firstly you'll
need to install Virtualbox and then Vagrant on your machine. Next install 
Packer.

Then create directories:
```sh
$ mkdir ubuntu ubuntu/http ubuntu/output ubuntu/scripts
$ cd ubuntu
```

`http` will hold our configuration files for Ubuntu, `output` will store our 
disk image we build and `scripts` will hold any scripts we want to run.

Ubuntu 20.04 has a new way to automate installs (they used to use debian preseed 
files) - [they now use a yaml file][ubuntu-auto-install] (also see their handy [quickstart][ubuntu-auto-quickstart] on which I based the below file), so we'll need to create it:
```sh
$ cat > http/user-data << 'EOF'
#cloud-config
autoinstall:
    version: 1
    locale: en_US
    keyboard:
      layout: en
      variant: uk
    identity:
      hostname: vagrant
      password: '$2y$12$zfS.Dpm682guriw6fJ5PXu4Kv7GSs7VYHUPGphQdSnT0wb4Rt1tVS'
      username: vagrant
    ssh:
      install-server: true
EOF
$ touch http/meta-data
```

As you can see, we set a hostname, username, password - all the normal things you 
would need to set up. We should now have two files - `http/user-data` containing 
our setup information and also `http/meta-data`.


Next, we should set up our script(s) - we'll setup just one for now:
```sh
$ cat > scripts/init.sh << 'EOF'
#!/bin/bash

sudo apt update
sudo apt upgrade -y
EOF
```

Finally, we should set up our Packer configuration file 
([config options for virtualbox explained here][packer-virtualbox] and 
for [vagrant options][packer-vagrant]):

```sh
{% raw %}
$ cat > ubuntu2004.json << 'EOF'
{
    "builders": [
      {
        "name": "ubuntu-2004",
        "type": "virtualbox-iso",
        "guest_os_type": "ubuntu-64",
        "headless": false,
  
        "iso_url": "http://releases.ubuntu.com/20.04/ubuntu-20.04-live-server-amd64.iso",
        "iso_checksum": "caf3fd69c77c439f162e2ba6040e9c320c4ff0d69aad1340a514319a9264df9f",
        "iso_checksum_type": "sha256",
  
        "ssh_username": "vagrant",
        "ssh_password": "vagrant",
        "ssh_handshake_attempts": "20",

        "http_directory": "http",
        "memory": 1024,

        "boot_wait": "5s",
        "boot_command": [
          "<enter><enter><f6><esc><wait> ",
          "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
          "<enter>"
        ],
        "shutdown_command": "echo 'vagrant'|sudo -S shutdown -P now",
        "guest_additions_path": "VBoxGuestAdditions_{{.Version}}.iso",
        "virtualbox_version_file": ".vbox_version",
        "vm_name": "packer-ubuntu-20.04-amd64",
        "vboxmanage": [
        [
            "modifyvm",
            "{{.Name}}",
            "--memory",
            "1024"
        ],
        [
            "modifyvm",
            "{{.Name}}",
            "--cpus",
            "1"
        ]
        ]
      }
    ],
    "provisioners": [
        {
            "type": "shell",
            "script": "scripts/init.sh",
            "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
        },
        {
            "type": "shell",
            "script": "scripts/cleanup.sh",
            "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
        }    
    ],
    "post-processors": [{
      "type": "vagrant",
      "compression_level": "8",
      "output": "output/ubuntu-20.04.box"
    }]
  }

EOF
{% endraw %} 
```

Then we can build the image:
```sh
$ packer build ubuntu2004.json
```

And add it to Vagrant:
```sh
$ vagrant box add --name ubuntu20.04 output/ubuntu-20.04.box
```

Finally, in any other directory, we can create a `Vagrantfile`:
```sh
$ cat > Vagrantfile << 'EOF'
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu20.04"
  config.ssh.password = "vagrant"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  end
end

EOF
```

Then lastly, all we need to do:
```
$ vagrant up && vagrant ssh
```

You should now be in your very own configured machine! 

You can also [reference my repository][repo] if you get stuck, it has configuration 
for Ubuntu 18.04 also. 

[fossa]: http://cdimage.ubuntu.com/ubuntu/releases/focal/release/
[Packer]: https://packer.io
[Virtualbox]: https://www.virtualbox.org/
[Vagrant]: https://www.vagrantup.com/
[ubuntu-auto-install]: https://wiki.ubuntu.com/FoundationsTeam/AutomatedServerInstalls
[ubuntu-auto-quickstart]: https://wiki.ubuntu.com/FoundationsTeam/AutomatedServerInstalls/QuickStart
[packer-virtualbox]: https://www.packer.io/docs/builders/virtualbox-iso.html
[packer-vagrant]: https://www.packer.io/docs/builders/vagrant/
[repo]: https://github.com/dueyfinster/packer/tree/01a97455686fcee1776f5c4d7d32504a6f71b5f8/ubuntu