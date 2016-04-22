This vagrant box installs elasticsearch 2.1, logstash 2.1, kibana3 with nginx, packetbeats and kibana 4.3

This repo has been updated from the [original](https://github.com/comperiosearch/vagrant-elk-box-ansible.git) which includes elasticsearch 2.1, logstash 2.1 and kibana 4.3 and was meant to replace the old [Vagrant ELK box](https://github.com/comperiosearch/vagrant-elk-box),  where provisioning by puppet has been replaced by ansible.

## Prerequisites

[VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) (minimum version 1.6)
Other providers, like VMWare may work, not tested!

## Checkout the project
This repo uses git submodules.
To clone the repo, use the --recurse-submodules option.  The submodules contain role definitions and nothing will work without that, unfortunately.  

**Packetbeat** branch is experimental and might be sometimes broken.

This branch is used to add features and try them before adding them on master branch.

If you want to try my current working branch, please clone as follows:

	git clone --recurse-submodules -b packetbeat --single-branch https://github.com/netmanito/vagrant-elk-box-ansible.git

The original repo from my fork can be cloned through 

    git clone --recurse-submodules  https://github.com/comperiosearch/vagrant-elk-box-ansible.git

If you need to pull in latest changes, please uses

     git pull --recurse-submodules
     git submodule update --init --recursive

## Up and SSH

To start the vagrant box run:

    vagrant up

To log in to the machine run:

    vagrant ssh

Elasticsearch will be available on the host machine at [http://localhost:9200/](http://localhost:9200/) 

Kibana3 at [http://localhost:8080/](http://localhost:8080/)

Kibana4 at [http://localhost:5601/](http://localhost:5601/)

Sense, the wonderful elasticsearch query machine is found at [http://localhost:5601/app/sense](http://localhost:5601/app/sense)


### Elasticsearch
Installed via debian package, started on boot.
Controlled by

```bash

 sudo service elasticsearch

```

There's a script at **include/example-logs/show_incides.sh** to check wether indexes have been created from logstash, packetbeats and kibana.

### Logstash
Installed via debian package, started on boot.
Controlled by

```bash

 sudo service logstash

```

Some sample Logstash data is installed on provisioning. Reading in log lines from **include/example-logs/testlog**

There's a script at **include/example-logs/send_log.sh** which includes data on testlog file with current date so you can have **on time** data as soon as you start. 

### Packetbeat
Installed via debian package, started on boot.
Controlled by

```bash

 sudo service packetbeat

```

It automatically creates a packetbeat-\* index on elasticsearch so you can see data the first time it runs.


### Kibana4
Controlled by

```bash

sudo service kibana

```

### Kibana3

Added as I still work with this version, it downloads directly from [kibana-community/kibana3](https://github.com/kibana-community/kibana3.git) repo.

It works through nginx as a default configuration on port 80 in the **vagrant-box** but forwarded to http://localhost:8080

### Nginx

Nginx is installed to serve kibana3 service

## Ansible provisioning
Ansible is installed on the guest machine by the setup.sh bash script which is run as part of vagrant provisioning. Vagrant does actually have a "built-in" provisioner for ansible, but it runs on the host machine, making that option unavailable on windows. Myself being one of the unfortunate we roll our own setup installing ansible on the guest machine.  The last step in the provisioning script is running the playbook located at provisioning/playbook.yml. 

The code for the Ansible init script was heavily inspired by this blog http://akrabat.com/provisioning-with-ansible-within-the-vagrant-guest/
