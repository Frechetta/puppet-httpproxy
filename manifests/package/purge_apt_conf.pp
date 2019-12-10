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

# package/purge_apt_conf.pp (private class)
# Purges apt.conf
# Purges apt.conf to ensure proxy management is handled by the module.
# Dangerous! Don't use if you have settings in apt.conf
class httpproxy::package::purge_apt_conf {

  file { '/etc/apt/apt.conf':
    ensure => absent,
  }
}
