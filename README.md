# [Puppet](https://puppetlabs.com/) apache_storm module

[![Build Status](https://travis-ci.org/christiangda/puppet-apache_storm.svg?branch=master)](https://travis-ci.org/christiangda/puppet-apache_storm)
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

A one-maybe-two sentence summary of what the module does/what problem it solves.
This is your 30 second elevator pitch for your module. Consider including
OS/Puppet version it works with.

## Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What apache_storm affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with apache_storm

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

### Install rubygems first
```bash
gem install bundler
```            

### Install all required gems in .vendor/
```bash
bundle install --path .vendor
```            

### Ignore this folder in .gitignore or globally.

### We can already use puppet-lint.
```bash
bundle exec puppet-lint
```            

### We can already use rspec-puppet
```bash
bundle exec rspec-puppet-init
```

### We can already use rake -T to see options
```bash
bundle exec rake -T
```

### We can already use rake -T to see options
```bash
bundle exec rake lint
```

## Development / contributing

1. [Fork it](https://github.com/christiangda/puppet-apache_storm#fork-destination-box)
2. [Clone it](https://github.com/christiangda/puppet-apache_storm.git) (`git clone https://github.com/christiangda/puppet-apache_storm.git; cd puppet-apache_storm`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. [Create new Pull Request](https://github.com/christiangda/puppet-apache_storm/pull/new/master)

Of course, bug reports and suggestions for improvements are always
welcome. GitHub pull requests are even better! :-)

You can also support my work on apache_storm via
[Gratipay](https://gratipay.com/~645e3ac3c159/).

[![Support via Gratipay](https://cdn.rawgit.com/gratipay/gratipay-badge/2.1.3/dist/gratipay.png)](https://gratipay.com/~645e3ac3c159/)
