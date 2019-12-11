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
WARNING: This module will default to wiping any proxies in profile.d, apt conf.d, and yum.conf. Pass false to disable
the module from handling those software packages.

This module was created to streamline proxy management of popular software. It can place and remove
proxies in profile.d, apt, yum, and wget. Currently only http (no https) proxies are supported.

## Usage
    class { 'httpproxy':
        http_proxy      => 'my.proxy.com',
        http_proxy_port => '80',
        http_proxy_user => 'proxy_user',
        http_proxy_pass => 'proxy_pass',
        no_proxy        => 'intranet.com',
        wget            => true,
        profiled        => true,
        packagemanager  => true,
        gem             => true,
        git             => true,
        purge_apt_conf  => false,
    }

Puppet will manage the proxy for the desired software when its boolean is set to true. When a proxy is entered,
puppet will ensure that the proxy is present. If a proxy is left undefined, puppet will remove whatever proxy it
placed (ensure absent). If the boolean is set to false, nothing will be removed or placed.

The no_proxy parameter takes a comma separated string of addresses to be ignored by the profile.d proxy.

If purge_apt_conf is set to true, the existing /etc/apt.conf file will be removed (if on Debian/Ubuntu) to ensure
the apt proxy is managed by this module.

## Reference

httpproxy uses the Unibets profile.d management module to manage proxies in profile.d. The puppetlabs/inifile
resource is used to manage the yum and wget proxies. The apt proxy is managed via the puppetlabs/apt module.

Please contribute, pull requests are welcome. The more proxies that can be managed the better.

## Limitations

This module has been tested against Puppet 4, 5, 6, CentOS 5, 6, 7, and Ubuntu 14.04, 16.04, 18.04.

## Contributors

Chris Edester, Michael Callahan, and Eric Frechette
