# git.pp (private class)
# Manages proxy for git
class httpproxy::git {
    $ensure = $httpproxy::git ? {
        true    => $httpproxy::ensure,
        default => $httpproxy::git,
    }

    if $httpproxy::git::ensure == 'present' {
        exec { "$(which git) config --system http.proxy ${httpproxy::proxy_uri}": }
    } elsif $httpproxy::git::ensure == 'absent' {
        exec { '$(which git) config --system --unset http.proxy': }
    }
}
