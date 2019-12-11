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

# git.pp (private class)
# Manages proxy for git
class httpproxy::git {
    $ensure = $httpproxy::git ? {
        true    => $httpproxy::ensure,
        default => $httpproxy::git,
    }

    if $httpproxy::git::ensure == 'present' {
        exec { 'git-proxy':
            command => "/usr/bin/git config --system http.proxy ${httpproxy::proxy_uri}",
            unless  => "/bin/test \"$(/usr/bin/git config --system --get http.proxy)\" == \"${httpproxy::proxy_uri}\"",
            # path    => [ '/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin' ],
        }
    } elsif $httpproxy::git::ensure == 'absent' {
        exec { 'git-proxy':
            command => '/usr/bin/git config --system --unset http.proxy',
            unless  => '/bin/test -z $(git config --system --get http.proxy)',
            # path    => [ '/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin' ],
        }
    }
}
