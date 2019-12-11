# Frechetta-httpproxy
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

# == define: httpproxy::gem
#
# Calling this define will enable proxy management for the ruby gem utility
#
# === Variables
#
# [$ensure]
#   Should be 'present' or 'absent'. If 'absent', Puppet will ensure the file at $path is absent.
#   Default: present
#   This variable is optional.
#
# [$path]
#   The path to the ruby config file.
#   Default: /etc/gemrc
#   This variable is optional.
#
# === Examples
#
# httpproxy::gem { 'httpproxy-gem': }   # with defaults
#
# httpproxy::gem { 'httpproxy-gem':     # with custom path
#   path => '/root/.gemrc',
# }
#
# httpproxy::gem { 'httpproxy-gem':     # ensure gem proxy isn't set
#   ensure => 'absent',
# }
#
define httpproxy::gem (
  $ensure = 'present',
  $path   = '/etc/gemrc',
) {
  $lines = [
    '# File managed by Puppet',
    '',
    "http_proxy: \"${httpproxy::proxy_uri}\"",
    '',
  ]

  file { $path:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => join($lines, "\n"),
  }
}
