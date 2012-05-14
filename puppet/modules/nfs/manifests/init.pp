class nfs::client { 

    package { nfs-utils:
        name => $operatingsystem ? {
            redhat    => ['nfs-utils', 'nfs-utils-lib'],
            fedora    => ['nfs-utils', 'nfs-utils-lib'],
            debian    => ['nfs-common', 'rpcbind'],
            },
        ensure => installed,
    }

    file {
        '/mnt/and':
            mode    => 0755,
            ensure  => directory,
            owner   => 'and',
            group   => 'and',
#           require => File['/etc/nsswitch.conf'],
    }

    service {
        'rpcbind':
            enable    => true,
            ensure    => running,
            hasstatus => true,
    }

    service { 'nfs':
        name => $operatingsystem ? {
            "redhat" => ['nfs'],
            "fedora" => ['nfs'],
            "debian" => ['nfs-common'],                                  
            },
        enable    => true,
        ensure    => running,
        hasstatus => true,
    }

# Mount points.
    mount {
        '/mnt/nfs-storage':
            device  => 'button:/home/and/nfs-storage',
            fstype  => nfs,
            ensure  => mounted,
            atboot  => 'true',
            options => 'rw,nosuid,nodev,hard,intr,bg,rsize=8192,wsize=8192',
#           require => File['/mnt/nfs-storage'],
    }
}

class nfs::server {
    package { nfs-utils:
        name => $operatingsystem ? {
            redhat    => ['nfs-utils', 'nfs-utils-lib'],
            fedora    => ['nfs-utils', 'nfs-utils-lib'],
            debian    => ['nfs-common', 'rpcbind', 'nfs-kernel-server'],
            },
        ensure => installed,
    }

    service {
        'rpcbind':
            enable    => true,
            ensure    => running,
            hasstatus => true,
    }

    service { 'nfs':
        name => $operatingsystem ? {
            "redhat" => ['nfs'],
            "fedora" => ['nfs'],
            "debian" => ['nfs-common'],
            },
        enable    => true,
        ensure    => running,
        hasstatus => true,
    }

#    service {
#        'nfs':
#            enable    => true,
#            ensure    => running,
#            hasstatus => true,
#             require   => $operatingsystem ? {
#                            "redhat" => [Service['rpcbind'], Package['nfs-utils']],
#                            "fedora" => [Service['rpcbind'], Package['nfs-utils']],
#                            "debian" => [Service['rpcbind'], Package['nfs-common', 'rpcbind']],
#                         }
#    }

    file {  
        'exports':
            path        => "/etc/exports",
            mode        => 644,
            owner       => root,
            group       => root,
            ensure      => present,
            source      => "puppet:///modules/nfs/exports",
            notify      => Exec['exportfs'],
    }

    exec {"exportfs":
        command     => "/usr/sbin/exportfs -a",
        refreshonly => true,
    }
}
