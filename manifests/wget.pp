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

# wget.pp (private class)
# Manages proxies for the popular wget file downloader
# Uses the puppetlabs/inifile resource
# https://forge.puppetlabs.com/puppetlabs/inifile
class httpproxy::wget {

  $ensure = $httpproxy::wget ? {
    true    => $httpproxy::ensure,
    default => $httpproxy::wget,
  }

  # Writes ini settings defined in init.pp in the wget configuration file.
  ini_setting { 'wget-http_proxy':
    ensure  => $ensure,
    path    => '/etc/wgetrc',
    section => '',
    setting => 'http_proxy',
    value   => $httpproxy::proxy_uri,
  }
  # Writes "https" setting. This module does not support https so it uses whatever is specified for http.
  ini_setting { 'wget-https_proxy':
    ensure  => $ensure,
    path    => '/etc/wgetrc',
    section => '',
    setting => 'https_proxy',
    value   => $httpproxy::proxy_uri,
  }
}
