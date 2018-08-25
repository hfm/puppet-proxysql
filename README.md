# puppet-proxysql [![Build Status](https://travis-ci.org/hfm/puppet-proxysql.svg?branch=master)](https://travis-ci.org/hfm/puppet-proxysql) [![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/proxysql.svg?style=flat-square)](https://forge.puppetlabs.com/hfm/proxysql)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with proxysql](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with proxysql](#beginning-with-proxysql)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Public Class: proxysql](#public-class-proxysql)
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
proxysql::configs:
  admin_variables:
    admin_credentials: 'admin:admin;remoteadmin:remateadminpass'
    mysql_ifaces: '0.0.0.0:6032'
  mysql_variables:
    threads: 8
    max_connections: 4096
    interfaces: '0.0.0.0:3306'
    stacksize: 1048576
    ping_interval_server_msec: 10000
  mysql_servers:
    address: mysql
    port: 3306
    hostgroup: 0
  mysql_users:
    username: root
  mysql_query_rules:
    rule_id: 1
    active: 1
    match_pattern: '.'
    log: 1
    apply: 0
```

## Reference

### Public Class: `proxysql`

#### parameters

Parameter | Data type | Description | Default
---|---|---|---
`package_ensure`   | String                  | What state the package should be in.                 | 'installed'
`datadir`          | Stdlib::Absolutepath    | Path to data directory.                              | '/var/lib/proxysql'
`datadir_mode`     | Stdlib::Filemode        | The permissions for the data directory.              | '0700'
`logdir`           | Stdlib::Absolutepath    | Path to log directory.                               | '/var/log/proxysql'
`logdir_mode`      | Stdlib::Filemode        | The permissions for the log directory.               | '0700'
`configfile`       | Stdlib::Absolutepath    | Path to configuration file.                          | '/etc/proxysql.cnf'
`configfile_owner` | String                  | The user of the config file.                         | 'root'
`configfile_group` | String                  | The group of the config file.                        | 'root'
`configfile_mode`  | Stdlib::Filemode        | The permissions for the config file.                 | '0600'
`service_ensure`   | Stdlib::Ensure::Service | Whether proxysql should be running.                  | 'running'
`service_enable`   | Boolean                 | Whether proxysql should be enabled to start at boot. | true
`configs`          | Hash                    | The Configuration hashes for proxysql.cnf            | See [data/common.yaml](./data/common.yaml)

#### Private Classes

- `proxysql::repo`
- `proxysql::install`
- `proxysql::config`
- `proxysql::service`

## Limitations

See `operatingsystem_support` in [metadata.json](./metadata.json)

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
