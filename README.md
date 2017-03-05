# [Puppet](https://puppetlabs.com/) apache_storm module

[![Build Status](https://travis-ci.org/christiangda/puppet-apache_storm.svg?branch=master)](https://travis-ci.org/christiangda/puppet-apache_storm)
[![Code Climate](https://codeclimate.com/github/christiangda/puppet-apache_storm/badges/gpa.svg)](https://codeclimate.com/github/christiangda/puppet-apache_storm)
[![Test Coverage](https://codeclimate.com/github/christiangda/puppet-apache_storm/badges/coverage.svg)](https://codeclimate.com/github/christiangda/puppet-apache_storm/coverage)
[![Issue Count](https://codeclimate.com/github/christiangda/puppet-apache_storm/badges/issue_count.svg)](https://codeclimate.com/github/christiangda/puppet-apache_storm)
[![Puppet Forge](http://img.shields.io/puppetforge/v/christiangda/apache_storm.svg)](https://forge.puppetlabs.com/christiangda/apache_storm)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/christiangda/apache_storm.svg)](https://forge.puppetlabs.com/christiangda/apache_storm/scores)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with apache_storm](#setup)
    * [What apache_storm affects](#what-apache_storm-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with apache_storm](#beginning-with-apache_storm)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Authors - Who is contributing to do it](#authors)
8. [License](#license)

## Overview

This is a [Puppet](https://puppetlabs.com/) module to manage [Apache Storm](http://storm.apache.org/).  
With this module you can installs, configures, and manages the [Apache Storm](http://storm.apache.org/) services.

This module were designed to work with:
* Debian OS Family and Redhat OS Family
* [Puppet](https://puppetlabs.com/) version >= 3.8.0
* [Apache Storm](http://storm.apache.org/) version >= 1.0.0

### How to Install

Execute the following command in your puppet server:
```bash
puppet module install christiangda-apache_storm
```
### How to Use

See [Usage](#usage)

**Note**

You need to take this consideration before start with the module
* [apache_storm](https://github.com/christiangda/puppet-apache_storm) module needs that you provison [Java](https://www.java.com) by your own way.
* Verified that you don't not have installed [Apache Storm](http://storm.apache.org/) from your OS Package Manager.

## Module Description

[apache_storm](https://github.com/christiangda/puppet-apache_storm) is a module designed to provision
[Apache Storm](http://storm.apache.org/) from its binary package [downloaded from a mirror link](http://www.apache.org/dyn/closer.lua/storm/apache-storm-1.0.2/apache-storm-1.0.2.tar.gz). This module was designed to be independent from your system packages, so you need to be sure that you don't have installed [Apache Storm](http://storm.apache.org/) from your OS package manager.

By default this module will install [Apache Storm](http://storm.apache.org/) in the `/opt/apache-storm` folder and create two symbolic links:  `/etc/apache-storm` and `/var/log/apache-storm`.  Is very recommended you add a extra volume and mount it in `/opt`

This module permit you to disable the service management, in case you want to use external tool, like [supervisord](http://supervisord.org/)

## Setup

### What [apache_storm](https://github.com/christiangda/puppet-apache_storm)  affects

#### Folders Created:
```bash
/opt/apache-storm/
├── current -> /opt/apache-storm/releases/apache-storm-1.0.2
├── releases
│   ├── apache-storm-1.0.1
│   │   ├── bin
│   │   ├── conf
│   │   ├── examples
│   │   ├── external
│   │   ├── extlib
│   │   ├── extlib-daemon
│   │   ├── lib
│   │   ├── log4j2
│   │   ├── logs
│   │   └── public
│   └── apache-storm-1.0.2
│       ├── bin
│       ├── conf
│       ├── examples
│       ├── external
│       ├── extlib
│       ├── extlib-daemon
│       ├── lib
│       ├── log4j2
│       ├── logs
│       └── public
├── sources
│   ├── apache-storm-1.0.1.tar.gz
│   └── apache-storm-1.0.2.tar.gz
└── storm_local_dir
```

#### Symbolic links
```bash
/etc/apache-storm -> /opt/apache-storm/releases/apache-storm-1.0.2/conf
/var/log/apache-storm -> /opt/apache-storm/releases/apache-storm-1.0.2/logs
```

#### Services' files

**Debian Family**
```bash
/etc/init/apache-storm-[nimbus|supervisor|ui|logviewer|drpc].conf
```

**Redhat Family**
```bash
/etc/systemd/system/apache-storm-[nimbus|supervisor|ui|logviewer|drpc].service
```

#### export PATH file
```bash
/etc/profile.d/apache-storm.sh
```

### Setup Requirements

This module requires that you provision [Java](https://www.java.com).  You can use a [Puppet](https://puppetlabs.com/) module from [puppetforge](https://forge.puppet.com/) to do that, or your OS Package manager.

For [Java's](https://www.java.com) version and provider see the recommendation in [Apache Storm web page](http://storm.apache.org/)

### Beginning with [apache_storm](https://github.com/christiangda/puppet-apache_storm)


### Install

Use these steps if you already have a version of the firewall module installed.

```bash
puppet module install christiangda-apache_storm
```

### Upgrade

Use these steps if you already have a version of the firewall module installed.

```bash
puppet module upgrade christiangda-apache_storm
```

## Usage

### Very basic usage

in your manifest file
```puppet
node 'storm.mynetwork.local' {
  # if you are using puppet's java module
  include java

  # Using this apache_storm module
  include ::apache_storm
  ::apache_storm::service { 'nimbus': }
  ::apache_storm::service { 'ui': }
  ::apache_storm::service { 'supervisor': }
  ::apache_storm::service { 'logviewer': }
  ::apache_storm::service { 'drpc': }
}
```

### Using parameters

in your manifest file
```puppet
node 'storm-nimbus.mynetwork.local' {
  # if you are using puppet's java module
  include java

  # Using this apache_storm module
  class { 'apache_storm':
    ensure    => 'present',
    version   => '1.0.2',
    repo_base => 'http://apache.claz.org/storm',
    config    => {
      'supervisor.slots.ports'      => [6700, 6701, 6702, 6703, 6704],
      'storm.zookeeper.servers'     => ['zk-01.mynetwork.local', 'zk-02.mynetwork.local', 'zk-03.mynetwork.local'],
      'client.jartransformer.class' => 'org.apache.storm.hack.StormShadeTransformer',
    }
  }

  ::apache_storm::service { 'nimbus':
    manage_service => true,
    service_ensure => 'present',
  }
  ::apache_storm::service { 'ui': }

}

node 'storm-supervisor.mynetwork.local' {
  # if you are using puppet's java module
  include java

  # Using this apache_storm module
  class { 'apache_storm':
    ensure    => 'present',
    version   => '1.0.2',
    repo_base => 'http://apache.claz.org/storm',
    config    => {
      'supervisor.slots.ports'      => [6700, 6701, 6702, 6703, 6704],
      'storm.zookeeper.servers'     => ['zk-01.mynetwork.local', 'zk-02.mynetwork.local', 'zk-03.mynetwork.local'],
      'client.jartransformer.class' => 'org.apache.storm.hack.StormShadeTransformer',
    }
  }

  ::apache_storm::service { 'supervisor':
    manage_service => true,
    service_ensure => 'present',
  }
  ::apache_storm::service { 'logviewer': }
  ::apache_storm::service { 'drpc': }
}
```

## Reference

* [Puppet](https://puppetlabs.com/)
* [Apache Storm](http://storm.apache.org/)
* [Rubocop](https://github.com/bbatsov/rubocop)
* [rspec-puppet](http://rspec-puppet.com/)
* [puppet-blacksmith](https://github.com/voxpupuli/puppet-blacksmith)
* [RSpec For Ops Part 2: Diving in with rspec-puppet](http://blog.danzil.io/page2/)

## Limitations

This module were designed to work with:
* Debian OS Family and Redhat OS Family
* [Puppet](https://puppetlabs.com/) version >= 3.8.0
* [Apache Storm](http://storm.apache.org/) version >= 1.0.0

## Development / Contributing

* [Fork it](https://github.com/christiangda/puppet-apache_storm#fork-destination-box) / [Clone it](https://github.com/christiangda/puppet-apache_storm.git) (`git clone https://github.com/christiangda/puppet-apache_storm.git; cd puppet-apache_storm`)
* Create your feature branch (`git checkout -b my-new-feature`)
* Install [rvm]()
* Install ruby `rvm install 2.3`
* Install ruby `rvm usage ruby-2.3.3` in my case
* Install bundler app first (`gem install bundler`)
* Install rubygems dependecies in .vendor folder (`bundle install --path .vendor`)
* Make your changes / improvements / fixes / etc, and of course **your Unit Test** for new code
* Run the tests (`bundle exec rubocop && bundle exec rake test`)
* Commit your changes (`git add . && git commit -m 'Added some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* [Create new Pull Request](https://github.com/christiangda/puppet-apache_storm/pull/new/master)

This code has Unit Tests, and was builded using:
* [Rubocop](https://github.com/bbatsov/rubocop)
* [rspec-puppet](http://rspec-puppet.com/)
* [puppet-blacksmith](https://github.com/voxpupuli/puppet-blacksmith)
* and others ([see Gemfile](Gemfile))

**Of course, bug reports and suggestions for improvements are always welcome.**

You can also support my work on apache_storm via

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/christiangda)

[![Support via Gratipay](https://cdn.rawgit.com/gratipay/gratipay-badge/2.1.3/dist/gratipay.png)](https://gratipay.com/~645e3ac3c159/)


## Authors

* [Christian González](https://github.com/christiangda)

## License

This module is released under the Apache License Version 2.0:

* [https://www.apache.org/licenses/LICENSE-2.0](https://www.apache.org/licenses/LICENSE-2.0)
