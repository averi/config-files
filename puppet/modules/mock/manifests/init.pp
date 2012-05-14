class mock {
        package {
             mock: ensure => present;
        }

        package {
             ccache: ensure => present;
        }

        package {
             yum-utils: ensure => present;
        }

        package {
             rpm-build: ensure => present;
        }

        file { "default.cfg":
                path => "/etc/mock/default.cfg",
                mode => 644,
                owner => root,
                group => root,
                require => Package["mock"],
                ensure => present,
                source => "puppet:///modules/mock/default.cfg"
        }
        file { "epel-5-i386.cfg":
                path => "/etc/mock/epel-5-i386.cfg",
                mode => 644,
                owner => root,
                group => root,
                require => Package["mock"],
                ensure => present,
                source => "puppet:///modules/mock/epel-5-i386.cfg"
        }
        file { "epel-5-x86_64.cfg":
                path => "/etc/mock/epel-5-x86_64.cfg",
                mode => 644,
                owner => root,
                group => root,
                require => Package["mock"],
                ensure => present,
                source => "puppet:///modules/mock/epel-5-x86_64.cfg"
        }
        file { "epel-6-i386.cfg":
                path => "/etc/mock/epel-6-i386.cfg",
                mode => 644,
                owner => root,
                group => root,
                require => Package["mock"],
                ensure => present,
                source => "puppet:///modules/mock/epel-6-i386.cfg"
        }
        file { "epel-6-x86_64.cfg":
                path => "/etc/mock/epel-6-x86_64.cfg",
                mode => 644,
                owner => root,
                group => root,
                require => Package["mock"],
                ensure => present,
                source => "puppet:///modules/mock/epel-6-x86_64.cfg"
        }

        file { "site-defaults.cfg":
                path => "/etc/mock/site-defaults.cfg",
                mode => 644,
                owner => root,
                group => root,
                require => Package["mock"],
                ensure => present,
                source => "puppet:///modules/mock/site-defaults.cfg"
        }

        file { "mockchain":
                path => "/usr/bin/mockchain",
                mode => 655,
                owner => root,
                group => root,
                require => Package["mock"],
                ensure => present,
                source => "puppet:///modules/mock/mockchain"
        }
}

