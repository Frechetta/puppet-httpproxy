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

# Profiled.pp (private class)
# Manages proxies in profile.d
# Uses the unibet/profiled module
# https://forge.puppetlabs.com/unibet/profiled
class httpproxy::profiled {

  $ensure = $httpproxy::profiled ? {
    true    => $httpproxy::ensure,
    default => $httpproxy::profiled,
  }

  if $httpproxy::no_proxy {
    $lines = [
      '# Set http proxy for shell',
      "export http_proxy=${httpproxy::proxy_uri}",
      "export https_proxy=${httpproxy::proxy_uri}",
      "export no_proxy=${httpproxy::no_proxy}",
    ]
  }
  else {
    $lines = [
      '# Set http proxy for shell',
      "export http_proxy=${httpproxy::proxy_uri}",
      "export https_proxy=${httpproxy::proxy_uri}",
    ]
  }

  # shell paramter enables or disables the shabang at the top of the bash script.
  profiled::script { 'httpproxy.sh':
    ensure  => $ensure,
    content => join($lines, "\n"),
    shell   => 'absent',
  }
}
