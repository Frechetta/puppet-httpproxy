httpproxy
=============

[![Build Status](https://travis-ci.org/Frechetta/puppet-httpproxy.svg?branch=master)](https://travis-ci.org/Frechetta/puppet-httpproxy)
[![Puppet Forge](https://img.shields.io/puppetforge/v/frechetta93/httpproxy.svg)](https://forge.puppet.com/frechetta93/httpproxy)
[![Puppet Forge Downloads](https://img.shields.io/puppetforge/dt/frechetta93/httpproxy.svg)](https://forge.puppet.com/frechetta93/httpproxy)
[![Puppet Forge Score](https://img.shields.io/puppetforge/f/frechetta93/httpproxy.svg)](https://forge.puppet.com/frechetta93/httpproxy/scores)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Contributors](#contributors)

## Overview
This module was created to streamline proxy management of popular software.
This software includes:
* apt
* yum
* rpm
* profile.d
* git
* wget
* ruby

Currently only http (no https) proxies are supported.

## Usage
First, declare the module with the proxy settings:

    class { 'httpproxy':
        url      => 'proxy.my.org',
        port     => '80',
        user     => 'proxy_user',
        pass     => 'proxy_pass',
        no_proxy => '.my.org',
    }

The no_proxy parameter takes a comma separated string of addresses to be ignored by the profile.d proxy.

To enable proxy management:

#### apt/yum/rpm

Defaults:

    httpproxy::packagemanager { 'proxy-pkg': }

Purge /etc/apt.conf:

    httpproxy::packagemanager { 'proxy-pkg':
        purge_apt_conf => true,
    }

If purge_apt_conf is set to true, the existing /etc/apt.conf file will be removed (if on Debian/Ubuntu) to ensure
the apt proxy is managed by this module.

#### profile.d

    httpproxy::profiled { 'proxy-profiled': }

#### git

    httpproxy::git { 'proxy-git': }

#### wget

    httpproxy::wget { 'proxy-wget': }

#### ruby

Defaults:

    httpproxy::gem { 'proxy-gem': }

Custom path:

    httpproxy::gem { 'httpproxy-gem':
        path => '/root/.gemrc',
    }

You may pass `ensure => 'absent'` to any of the modules above to ensure there is no proxy set for that module.

## Reference

httpproxy uses the Unibets profile.d management module to manage proxies in profile.d. The puppetlabs/inifile
resource is used to manage the yum and wget proxies. The apt proxy is managed via the puppetlabs/apt module.

Please contribute, pull requests are welcome. The more proxies that can be managed the better.

## Limitations

This module has been tested against Puppet 4, 5, 6, CentOS 5, 6, 7, and Ubuntu 14.04, 16.04, 18.04.

## Contributors

Chris Edester, Michael Callahan, and Eric Frechette
