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

# == define: httpproxy::package::yum
#
# Manages proxies for the yum package manager
# Uses the puppetlabs/inifile resource
# https://forge.puppetlabs.com/puppetlabs/inifile
#
define httpproxy::package::yum (
  $ensure = 'present',
) {
  ini_setting { 'yum_proxy':
    ensure  => $ensure,
    path    => '/etc/yum.conf',
    section => 'main',
    setting => 'proxy',
    value   => $httpproxy::proxy_uri,
  }
}
