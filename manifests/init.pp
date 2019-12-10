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

# init.pp
# Manages http proxies for various software
# Defines the httpproxy class. Sets the $http_proxy and $http_proxy_port variable to null.
class httpproxy (
  Optional[Stdlib::Host] $http_proxy      = undef,
  Optional[Stdlib::Port] $http_proxy_port = undef,
  $http_proxy_user = undef,
  $http_proxy_pass = undef,
  $no_proxy        = undef,
  $profiled        = true,
  $packagemanager  = true,
  $wget            = false,
  $gem             = false,
  $git             = false,
  Boolean $purge_apt_conf  = false,
){

  # Checks if $http_proxy contains a string. If $http_proxy is null $ensure is set to absent.
  # If $http_proxy contains a string then $ensure is set to present.
  $ensure = $http_proxy ? {
    undef   => 'absent',
    default => 'present',
  }

  # Checks if $http_proxy_port contains a string. If $http_proxy_port is null, $proxy_port_string
  # is set to null. Otherwise, a colon is added in front of $http_proxy_port and stored in
  # $proxy_port_string
  $proxy_port_string = $http_proxy_port ? {
    undef   => undef,
    default => ":${http_proxy_port}",
  }

  $proxy_cred_string = $http_proxy_user ? {
    undef   => undef,
    default => "${http_proxy_user}:${http_proxy_pass}@",
  }

  # Checks if $http_proxy contains a string. If it is null, $proxy_uri is set to null.
  # Otherwise, it will concatenate $http_proxy and $proxy_port_string.
  $proxy_uri = $http_proxy ? {
    undef   => undef,
    default => "http://${proxy_cred_string}${http_proxy}${proxy_port_string}",
  }

  # Boolean parameter for class selection
  if $profiled { contain '::httpproxy::profiled' }
  if $packagemanager { contain '::httpproxy::packagemanager' }
  if $wget { contain '::httpproxy::wget' }
  if $gem { contain '::httpproxy::gem' }
  if $git { contain '::httpproxy::git' }
}
