# Frechetta-httpproxy
# Copyright (C) 2015  Michael Callahan and Chris Edester
# Copyright (C) 2019  Eric Frechette

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# You can contact us through github

# == Class: httpproxy
#
# Manages http proxies for various software
#
# === Variables
#
# [$url]
#   The proxy url without the port or credentials. Ensure there is no protocol (http:// | https://) or trailing slash.
#   Example: http://my.proxy
#   Default: undef
#   This variable is required.
#
# [$port]
#   The proxy port.
#   Default: undef
#   This variable is optional.
#
# [$user]
#   The username used to authenticate with the proxy.
#   Default: undef
#   This variable is optional.
#
# [$pass]
#   The password used to authenticate with the proxy.
#   Default: undef
#   This variable is optional.
#
# [$no_proxy]
#   Comma separated string of addresses to be ignored by the proxy.
#   Default: undef
#   This variable is optional.
#
# === Examples
#
# class { httpproxy:    # without credentials
#   url      => 'proxy.my.org',
#   port     => 80,
#   no_proxy => '.my.org',
# }
#
# class { httpproxy:    # with credentials
#   url      => 'proxy.my.org',
#   port     => 80,
#   user     => 'proxy_user',
#   pass     => 'proxy_pass',
#   no_proxy => '.my.org',
# }
#
class httpproxy (
  Stdlib::Host $url = undef,
  Optional[Stdlib::Port] $port = undef,
  $user             = undef,
  $pass             = undef,
  $no_proxy         = undef,
) {
  # Checks if $port contains a string. If $port is null, $proxy_port_string
  # is set to null. Otherwise, a colon is added in front of $port and stored in
  # $proxy_port_string
  $proxy_port_string = $port ? {
    undef   => undef,
    default => ":${port}",
  }

  $proxy_cred_string = $user ? {
    undef   => undef,
    default => "${user}:${pass}@",
  }

  # Checks if $url contains a string. If it is null, $proxy_uri is set to null.
  # Otherwise, it will concatenate $url and $proxy_port_string.
  $proxy_uri = "http://${proxy_cred_string}${url}${proxy_port_string}"

  file { '/tmp/.proxy':
    ensure  => 'present',
    content => $proxy_uri,
  }
}
