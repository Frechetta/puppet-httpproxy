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
            # path    => [ '/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin' ],
        }
    } elsif $httpproxy::git::ensure == 'absent' {
        exec { 'git-proxy':
            command => '/usr/bin/git config --system --unset http.proxy',
            # path    => [ '/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin' ],
        }
    }
}
