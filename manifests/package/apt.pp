# package/apt.pp (private class)
# Uses the puppetlabs-apt module to manage apt package manager proxies
# https://forge.puppetlabs.com/puppetlabs/apt
class httpproxy::package::apt {
  $lines = [
    '# File managed by Puppet',
    '',
    "Acquire::http::Proxy \"${httpproxy::proxy_uri}\";",
    "Acquire::https::Proxy \"${httpproxy::proxy_uri}\";"
  ]

  file { '/etc/apt/apt.conf.d/05proxy':
    ensure  => $httpproxy::packagemanager::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => join($lines, "\n"),
  }
}
