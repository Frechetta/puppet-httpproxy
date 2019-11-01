# package/apt.pp (private class)
# Uses the puppetlabs-apt module to manage apt package manager proxies
# https://forge.puppetlabs.com/puppetlabs/apt
class httpproxy::package::apt {
  file { 'apt_via_proxy':
    ensure  => $httpproxy::packagemanager::ensure,
    path    => '/etc/apt/apt.conf.d/05proxy',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "Acquire::http::Proxy \"${httpproxy::proxy_uri}\";\nAcquire::https::Proxy \"${httpproxy::proxy_uri}\";",
  }
}
