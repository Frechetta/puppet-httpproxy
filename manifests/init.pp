# init.pp
# Manages http proxies for various software
# Defines the httpproxy class. Sets the $http_proxy and $http_proxy_port variable to null.
class httpproxy (
  Optional[Stdlib::Host] $http_proxy      = undef,
  Optional[Stdlib::Port] $http_proxy_port = undef,
  $http_proxy_user = undef,
  $http_proxy_pass = undef,
  $no_proxy        = undef,
  $profiled        = true,
  $packagemanager  = true,
  $wget            = false,
  Boolean $purge_apt_conf  = false,
){

  # Checks if $http_proxy contains a string. If $http_proxy is null $ensure is set to absent.
  # If $http_proxy contains a string then $ensure is set to present.
  $ensure = $http_proxy ? {
    undef   => 'absent',
    default => 'present',
  }

  # Checks if $http_proxy_port contains a string. If $http_proxy_port is null, $proxy_port_string
  # is set to null. Otherwise, a colon is added in front of $http_proxy_port and stored in
  # $proxy_port_string
  $proxy_port_string = $http_proxy_port ? {
    undef   => undef,
    default => ":${http_proxy_port}",
  }

  $proxy_cred_string = $http_proxy_user ? {
    undef   => undef,
    default => "${http_proxy_user}:${http_proxy_pass}@",
  }

  # Checks if $http_proxy contains a string. If it is null, $proxy_uri is set to null.
  # Otherwise, it will concatenate $http_proxy and $proxy_port_string.
  $proxy_uri = $http_proxy ? {
    undef   => undef,
    default => "http://${proxy_cred_string}${http_proxy}${proxy_port_string}",
  }

  # Boolean parameter for class selection
  if $profiled { contain '::httpproxy::profiled' }
  if $packagemanager { contain '::httpproxy::packagemanager' }
  if $wget { contain '::httpproxy::wget' }
}
