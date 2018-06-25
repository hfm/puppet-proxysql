# puppet-proxysql [![Build Status](https://travis-ci.org/hfm/puppet-proxysql.svg?branch=master)](https://travis-ci.org/hfm/puppet-proxysql) [![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/proxysql.svg?style=flat-square)](https://forge.puppetlabs.com/hfm/proxysql)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with proxysql](#setup)
    * [What proxysql affects](#what-proxysql-affects)
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

## Usage

This section is where you describe how to customize, configure, and do the fancy stuff with your module here. It's especially helpful if you include usage examples and code samples for doing things with your module.

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

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
