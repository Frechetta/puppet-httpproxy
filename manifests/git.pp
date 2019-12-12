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

# == define: httpproxy::git
#
# Calling this define will enable proxy management for git
#
# === Variables
#
# [$ensure]
#   Should be 'present' or 'absent'. If 'absent', Puppet will ensure the git http.proxy setting is empty
#   Default: present
#   This variable is optional.
#
# === Examples
#
# httpproxy::git { 'httpproxy-git': }   # with defaults
#
# httpproxy::git { 'httpproxy-git':     # ensure git proxy isn't set
#   ensure => 'absent',
# }
#
define httpproxy::git (
    $ensure = 'present',
) {
    if $ensure == 'present' {
        exec { 'git-proxy':
            command => "/usr/bin/git config --system http.proxy ${httpproxy::proxy_uri}",
            unless  => "/usr/bin/test \"$(/usr/bin/git config --system --get http.proxy)\" == \"${httpproxy::proxy_uri}\"",
            # path    => [ '/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin' ],
        }
    } elsif $ensure == 'absent' {
        exec { 'git-proxy':
            command => '/usr/bin/git config --system --unset http.proxy',
            unless  => '/usr/bin/test -z $(git config --system --get http.proxy)',
            # path    => [ '/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin' ],
        }
    }
}
