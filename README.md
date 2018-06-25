# puppet-proxysql [![Build Status](https://travis-ci.org/hfm/puppet-proxysql.svg?branch=master)](https://travis-ci.org/hfm/puppet-proxysql) [![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/proxysql.svg?style=flat-square)](https://forge.puppetlabs.com/hfm/proxysql)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with proxysql](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with proxysql](#beginning-with-proxysql)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

The proxysql module handles installing, configuring, and running [ProxySQL](http://www.proxysql.com).

## Setup

### Setup Requirements

The proxysql module requires the following puppet module:

- [puppetlabs-stdlib](https://forge.puppet.com/puppetlabs/stdlib): version 4.6.x or newer
- [camptocamp-systemd](https://forge.puppet.com/camptocamp/systemd): version 1.x
- [puppetlabs-apt](https://forge.puppet.com/puppetlabs/apt): version 4.x (only Debian-based distributions).

note: puppetlabs-apt is soft dependencies. If you are installing on Debian systems, you will need to configure appropriate versions of this module.

### Beginning with proxysql

To set up the proxysql with default parameters, declare the `proxysql` class like the following:

```puppet
include ::proxysql
```

## Usage

### Configuring modules in Puppet

To set up the proxysql in Puppet codes, you can configure like the following:

```puppet
class { '::proxysql':
  datadir      => '/var/lib/proxysql',
  datadir_mode => '0750',
  logdir       => '/var/log/proxysql',
  logdir_mode  => '0750'.
}
```

### Configuring modules from Hiera

To set up ProxySQL using Hiera, you declare `include ::proxysql` in puppet manifests and configure in Hiera like the following:

```yaml
---
proxysql::datadir: '/var/lib/proxysql'
proxysql::datadir_mode: '0750'
proxysql::logdir: '/var/log/proxysql'
proxysql::logdir_mode: '0750'
```

## Reference

Users need a complete list of your module's classes, types, defined types providers, facts, and functions, along with the parameters for each. You can provide this list either via Puppet Strings code comments or as a complete list in the README Reference section.

* If you are using Puppet Strings code comments, this Reference section should include Strings information so that your users know how to access your documentation.

* If you are not using Puppet Strings, include a list of all of your classes, defined types, and so on, along with their parameters. Each element in this listing should include:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there are Known Issues, you might want to include them under their own heading here.

## Development

### Running tests

The proxysql puppet module contains tests for both [rspec-puppet](http://rspec-puppet.com) (unit tests) and [beaker-rspec](https://github.com/puppetlabs/beaker-rspec) (acceptance tests) to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart

- Unit tests:

```console
$ bundle install
$ bundle exec rake
```

- Acceptance tests:

```console
# Set your DOCKER_HOST variable
$ eval "$(docker-machine env default)"

# List available beaker nodesets
$ bundle exec rake beaker_nodes
centos7
debian9

# Run beaker acceptance tests
$ BEAKER_set=debian9 bundle exec rake beaker
```