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
