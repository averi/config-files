class httpd::debian {

package {
    apache2:
         ensure => present;
    }

service {
    "apache2":
         ensure => running,
         enable => true,
         hasrestart => true,
         hasstatus => true,
         require => Package["apache2"]
     }

file { "/etc/apache2/apache2.conf":
            mode => 644,
            owner => root,
            group => root,
            ensure => present,
            source => "puppet:///modules/httpd/apache2.conf",
            require => [ Package["apache2"] ],
            notify => Service["apache2"];
     }

file { "/etc/apache2/ports.conf":
            mode => 644,
            owner => root,
            group => root,
            ensure => present,
            source => "puppet:///modules/httpd/ports.conf",
            require => [ Package["apache2"] ],
            notify => Service["apache2"];
     }

file { "/etc/apache2/sites-available":
            ensure => directory,
            recurse => true,
            purge => true,
            force => true,
            owner => "root",
            group => "root",
            mode => 0644,
            source => "puppet:///modules/httpd/sites-available-empty",
            notify => Service["apache2"];
     }

file { "/etc/apache2/sites-enabled":
            ensure => directory,
            recurse => true,
            purge => true,
            force => true,
            owner => "root",
            group => "root",
            mode => 0644,
            source => "puppet:///modules/httpd/sites-enabled-empty",
            notify => Service["apache2"];
     }

file { "/etc/apache2/sites-available/default":
            mode => 644,
            owner => root,
            group => root,
            ensure => present,
            source => "puppet:///modules/httpd/sites-available/default",
            require => [ Package["apache2"] ],
            notify => Service["apache2"];
     }

file { "/etc/apache2/sites-available/default-ssl":
            mode => 644,
            owner => root,
            group => root,
            ensure => present,
            source => "puppet:///modules/httpd/sites-available/default-ssl",
            require => [ Package["apache2"] ],
            notify => Service["apache2"];
     }

file { '/etc/apache2/sites-enabled/default':
   ensure => 'link',
   target => '/etc/apache2/sites-available/default',
   }

file { '/etc/apache2/sites-enabled/default-ssl':
   ensure => 'link',
   target => '/etc/apache2/sites-available/default-ssl',
   }

# Setup SSL (Running on port 444)

file { "/etc/apache2/ssl":
            ensure => directory,
            mode => 0644,
            owner => root,
            group => root,
     }

file { "/etc/apache2/ssl/sweetrevenge.no-ip.org-cert.pem":
           mode => 644,
           owner => root,
           group => root,
           ensure => present,
           source => "puppet:///modules/httpd/ssl/sweetrevenge.no-ip.org-cert.pem",
     }

file { "/etc/apache2/ssl/sweetrevenge.no-ip.org-key.pem":
           mode => 644,
           owner => root,
           group => root,
           ensure => present,
           source => "puppet:///modules/httpd/ssl/sweetrevenge.no-ip.org-key.pem",
     }
}

class httpd::redhat {

package {
    httpd:
         ensure => present;
    mod_ssl:
         ensure => present;
    }

service {
    "httpd":
         ensure => running,
         enable => true,
         hasrestart => true,
         hasstatus => true,
         require => Package["httpd"]
     }

file { "/etc/httpd/sites.d":
            ensure => directory,
            recurse => true,
            purge => true,
            force => true,
            owner => "root",
            group => "root",
            mode => 0644,
            source => "puppet:///modules/httpd/sites.d-empty",
            notify => Service["httpd"];
     }

# Setup the public_html directory
file { "/home/and/public_html":
            ensure => directory,
            owner => "and",
            group => "and",
            mode => 0644,
     }

file { "/etc/httpd/conf/httpd.conf":
            mode => 644,
            owner => root,
            group => root,
            ensure => present,
            content => template("httpd/httpd.conf"),
            require => [ Package["httpd"], File["/etc/httpd/sites.d"] ],
            notify => Service["httpd"];
     }

file { "/var/log/httpd":
            ensure => directory,
            mode => 750,
            owner => root,
            group => root,
            require => Package["httpd"],
     }

file { "/etc/httpd/conf.d/welcome.conf":
            mode => 644,
            owner => root,
            group => root,
            ensure => present,
            source => "puppet:///modules/httpd/welcome.conf",
            require => [ Package["httpd"] ];
     }

# Setup SSL
file { "/etc/httpd/ssl":
            ensure => directory,
            mode => 0644,
            owner => root,
            group => root,
     }

file { "/etc/httpd/conf.d/ssl.conf":
            mode => 644,
            owner => root,
            group => root,
            ensure => present,
            source => "puppet:///modules/httpd/ssl/ssl.conf",
            require => [ Package["mod_ssl"] ],
            notify => Service["httpd"];
     }

file { "/etc/httpd/ssl/sweetrevenge.no-ip.org-cert.pem":
           mode => 644,
           owner => root,
           group => root,
           ensure => present,
           source => "puppet:///modules/httpd/ssl/sweetrevenge.no-ip.org-cert.pem",
     }

file { "/etc/httpd/ssl/sweetrevenge.no-ip.org-key.pem":
           mode => 644,
           owner => root,
           group => root,
           ensure => present,
           source => "puppet:///modules/httpd/ssl/sweetrevenge.no-ip.org-key.pem",
     }
}

define httpd::vhost($name, $prefix="") {

    file { "/etc/httpd/sites.d/$prefix$name.conf":
        ensure => present,
        mode => 644,
        require => [ Package["httpd"], File["/var/log/httpd/$name"] ],
        source => "puppet:///modules/httpd/sites.d/$name.conf",
        notify => Service["httpd"]
    }

    file { "/var/log/httpd/$name":
        ensure => directory,
        mode => 755,
        owner => root,
        group => root,
        require => Package["httpd"]
    }
}


