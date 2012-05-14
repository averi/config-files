class postfix {

$gmailPassword = extlookup('gmailPassword')

    package { postfix:
        ensure => present
    }

    service { postfix: 
        ensure => running,
        enable => true,
        require => Package['postfix'] 
    }

    file { '/etc/postfix/main.cf':
        source => "puppet:///modules/postfix/main.cf/main.cf.$postfix_host",
        mode => 0644,
        notify => Service['postfix'],
        require => Package['postfix']
    }
    file { '/etc/postfix/master.cf':
        source =>  "puppet:///modules/postfix/master.cf/master.cf.$postfix_host",
        mode => 0644,
        notify => Service['postfix'],
        require => Package['postfix']
    }

    file { "/etc/postfix/sasl_passwd":
        mode    => 0400,
        content => template("postfix/sasl_passwd.erb"),
    }

    file { '/etc/postfix/virtual':
        source =>  "puppet:///modules/postfix/virtual/virtual.$postfix_host",
        mode => 0644,
    }

    file { '/etc/aliases':
        source =>  "puppet:///modules/postfix/aliases.$postfix_host",
        mode => 0644,
    }

    file { "/etc/postfix/ssl":
        ensure => "directory",
        owner   => "root",
        group   => "root",
        mode    => "0644",
    }

    file { "/etc/postfix/ssl/sweetrevenge.no-ip.org.key":
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/postfix/ssl/sweetrevenge.no-ip.org.key",
   }

    file { "/etc/postfix/ssl/sweetrevenge.no-ip.org.crt":
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/postfix/ssl/sweetrevenge.no-ip.org.crt",
   }

    file { "/etc/postfix/ssl/cacert.pem":
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/postfix/ssl/cacert.pem",
   }

    file { "/etc/postfix/smtp_tls_per_site":
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "puppet:///modules/postfix/smtp_tls_per_site",
   }

# Rerun newaliases and restart postfix if aliases updated:
exec {newaliases: command => "/usr/sbin/postalias /etc/aliases ; service postfix restart",
	subscribe => File["/etc/aliases"],
	refreshonly => true,
     }

# Rebuild the sasl_passwd.db file is sasl_passwd changes.
exec {postmap_sasl_passwd: command => "/usr/sbin/postmap /etc/postfix/sasl_passwd ; service postfix restart",
        subscribe => File["/etc/postfix/sasl_passwd"],
        refreshonly => true,
     }

# Rebuild the virtual.db file is virtual changes.
exec {postmap_virtual: command => "/usr/sbin/postmap /etc/postfix/virtual ; service postfix restart",
        subscribe => File["/etc/postfix/virtual"],
        refreshonly => true,
     }

# Rebuild the smtp_tls_per_site.db if smtp_tls_per_site changes.
exec {postmap_smtp_tls_per_site: command => "/usr/sbin/postmap /etc/postfix/smtp_tls_per_site ; service postfix restart",
        subscribe => File["/etc/postfix/smtp_tls_per_site"],
        refreshonly => true,
     }
}
