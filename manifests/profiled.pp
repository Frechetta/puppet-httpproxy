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

# == define: httpproxy::profiled
#
# Calling this define will add a script in /etc/profile.d/ called httpproxy.sh that exports
# http_proxy and https_proxy environment variables.
#
# Uses the unibet/profiled module
# https://forge.puppetlabs.com/unibet/profiled
#
# === Variables
#
# [$ensure]
#   Should be 'present' or 'absent'. If 'absent', Puppet will ensure httpproxy.sh is absent.
#   Default: present
#   This variable is optional.
#
# === Examples
#
# httpproxy::profiled { 'httpproxy-env': }   # with defaults
#
# httpproxy::profiled { 'httpproxy-env':     # ensure proxy isn't set
#   ensure => 'absent',
# }
#
define httpproxy::profiled (
  $ensure = 'present',
) {
  $base = [
    '# Set http proxy for shell',
    "export http_proxy=${httpproxy::proxy_uri}",
    "export https_proxy=${httpproxy::proxy_uri}",
  ]

  if $httpproxy::no_proxy {
    $lines = concat($base, ["export no_proxy=${httpproxy::no_proxy}"])
  } else {
    $lines = $base
  }

  # shell paramter enables or disables the shabang at the top of the bash script.
  profiled::script { 'httpproxy.sh':
    ensure  => $ensure,
    content => join($lines, "\n"),
    shell   => 'absent',
  }
}
