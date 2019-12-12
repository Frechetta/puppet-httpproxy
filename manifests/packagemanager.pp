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

# == define: httpproxy::packagemanager
#
# Calling this define will enable proxy management for the appropriate package handler class based on OS distribution
#
# === Variables
#
# [$ensure]
#   Should be 'present' or 'absent'. If 'absent', Puppet will ensure the proxy is not set.
#   Default: present
#   This variable is optional.
#
# [$purge_apt_conf]
#   If true, remove /etc/apt.conf to ensure it doesn't mess with /etc/apt.conf.d/ files.
#   Default: false
#   This variable is optional.
#
# === Examples
#
# httpproxy::packagemanager { 'httpproxy-pkg': }   # with defaults
#
# httpproxy::packagemanager { 'httpproxy-pkg':     # with purge_apt_conf
#   purge_apt_conf => true,
# }
#
# httpproxy::packagemanager { 'httpproxy-pkg':     # ensure proxy isn't set
#   ensure => 'absent',
# }
#
define httpproxy::packagemanager (
  $ensure = 'present',
  Boolean $purge_apt_conf = false,
) {
  case $::osfamily {
    'RedHat': {
      httpproxy::package::rpm { 'httpproxy-rpm': ensure => $ensure }
      httpproxy::package::yum { 'httpproxy-yum': ensure => $ensure }
    }
    'Debian': {
      # contain 'httpproxy::package::apt'
      httpproxy::package::apt { 'httpproxy-apt': ensure => $ensure }
      if $purge_apt_conf { contain 'httpproxy::package::purge_apt_conf' }
    }
    default: { fail('your distro is not supported') }
  }
}
