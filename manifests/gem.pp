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

# gem.pp (private class)
# Manages proxies for ruby gem utility
class httpproxy::gem {
  $ensure = $httpproxy::gem ? {
    true    => $httpproxy::ensure,
    default => $httpproxy::gem,
  }

  $lines = [
    '# File managed by Puppet',
    '',
    "http_proxy: \"${httpproxy::proxy_uri}\"",
    '',
  ]

  file { '/etc/gemrc':
    ensure  => $httpproxy::gem::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => join($lines, "\n"),
  }
}
