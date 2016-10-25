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

## Overview

This is a [Puppet](https://puppetlabs.com/) module to manage [Apache Storm](http://storm.apache.org/).  
With this module you can installs, configures, and manages the [Apache Storm](http://storm.apache.org/) services.

This module were designed to work with:
* Debian OS Family and Redhat OS Family
* [Puppet](https://puppetlabs.com/) version >= 3.8.0
* [Apache Storm](http://storm.apache.org/) version >= 1.0.0

### Howto Install

Execute the following command in your puppet server:
```bash
puppet module install christiangda/apache_storm
```

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
/etc/
├── apache-storm -> /opt/apache-storm/releases/apache-storm-1.0.2/conf

/var/log/
├── apache-storm -> /opt/apache-storm/releases/apache-storm-1.0.2/logs
```

#### Services' files

**Debian Family**
```bash
/etc/init
├── apache-storm-[nimbus|supervisor|ui|logviewer|drpc].conf
```

**Redhat Family**
```bash
/etc/systemd/system
├── apache-storm-[nimbus|supervisor|ui|logviewer|drpc].service
```

#### export PATH file
```bash
/etc/profile.d/apache-storm.sh
```

### Setup Requirements

This module requires that you provision [Java](https://www.java.com).  You can use a [Puppet's](https://puppetlabs.com/) module from [puppetforge](https://forge.puppet.com/) to do that, or your OS Package manager.

For [Java's](https://www.java.com) version and provider see the recommendation in [Apache Storm web page](http://storm.apache.org/)

### Beginning with [apache_storm](https://github.com/christiangda/puppet-apache_storm)


### Install

Use these steps if you already have a version of the firewall module installed.

```bash
puppet module install christiangda/apache_storm
```

### Upgrade

Use these steps if you already have a version of the firewall module installed.

```bash
puppet module upgrade christiangda/apache_storm
```

## Usage

The default
```puppet
include java

include ::apache_storm

::apache_storm::service { 'nimbus': }
::apache_storm::service { 'ui': }
::apache_storm::service { 'supervisor': }
::apache_storm::service { 'logviewer': }
::apache_storm::service { 'drpc': }
```

## Reference


## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development / Contributing

### For the impatient

1. [Fork it](https://github.com/christiangda/puppet-apache_storm#fork-destination-box) / [Clone it](https://github.com/christiangda/puppet-apache_storm.git) (`git clone https://github.com/christiangda/puppet-apache_storm.git; cd puppet-apache_storm`)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Install bundler app first (`gem install bundler`)
4. Install rubygems dependecies in .vendor folder (`bundle install --path .vendor`)
5. Make your changes / improvements / fixes / etc, and of course **your Unit Test** for new code
6. Run the tests (`bundle exec rubocop && bundle exec rake test`)
6. Commit your changes (`git add . && git commit -m 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. [Create new Pull Request](https://github.com/christiangda/puppet-apache_storm/pull/new/master)

This code has Unit Tests, and was builded using:
* [Rubocop](https://github.com/bbatsov/rubocop)
* [rspec-puppet](http://rspec-puppet.com/)
* [puppet-blacksmith](https://github.com/voxpupuli/puppet-blacksmith)
* and others

### Install rubygems first
```bash
gem install bundler
```            

### Install all required gems in .vendor/
```bash
bundle install --path .vendor
```            

### We can already use rake -T to see options
```bash
bundle exec rubocop && bundle exec rake test
```

**Of course, bug reports and suggestions for improvements are always welcome.**

You can also support my work on apache_storm via
[Gratipay](https://gratipay.com/~645e3ac3c159/).

[![Support via Gratipay](https://cdn.rawgit.com/gratipay/gratipay-badge/2.1.3/dist/gratipay.png)](https://gratipay.com/~645e3ac3c159/)
