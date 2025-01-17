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

# == define: httpproxy::package::rpm
#
# Manages proxies for the rpm package manager
# /usr/lib/rpm/macros
# Any per-system configuration
# should be added to /etc/rpm/macros
#
define httpproxy::package::rpm (
  $ensure = 'present',
) {
  $lines = [
    '# File managed by Puppet',
    '',
    "%_httpproxy ${httpproxy::proxy_uri}",
    '',
  ]

  file { '/etc/rpm/macros.httpproxy':
    ensure  => $ensure,
    group   => 'root',
    owner   => 'root',
    mode    => '0644',
    content => join($lines, "\n"),
  }
}
