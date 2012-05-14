class check_mk::client {

if $operatingsystem == RedHat {
     package { "check_mk-agent": 
        provider => rpm, 
        ensure => installed, 
        source => "http://mathias-kettner.de/download/check_mk-agent-1.1.12p7-1.noarch.rpm" 
    }
}
else {
    package {
      check-mk-agent: ensure => installed;
      nagios-nrpe-plugin: ensure => installed; # Needed for non-check_mk host's definitions.
    }
  }
}

class check_mk::server {

package {
    nagios3:  ensure => installed;
    check-mk-server: ensure => installed;
    check-mk-config-nagios3: ensure => installed;
}

service {"nagios3":
        enable => true,
        ensure  => running,
        hasstatus       => true,
        hasrestart      => true,
        require => Package[nagios3],
    }

file { "/etc/check_mk/main.mk":
     owner   => "root",
     group   => "root",
     mode    => 0664,
     source  => "puppet:///modules/check_mk/main.mk",
     require => Package["check-mk-server"],
   }

file { "/etc/nagios3/conf.d/check_mk/check_mk_objects.cfg":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/check_mk/check_mk_objects.cfg",
     require => Package["check-mk-config-nagios3"],
     notify => Service["nagios3"],
   }

file { "/etc/nagios3/conf.d/mrlawrence-lan.cfg":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/check_mk/mrlawrence-lan.cfg",
     require => Package["nagios3"],
     notify => Service["nagios3"],
   }

file { "/etc/nagios3/conf.d/button-lan.cfg":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/check_mk/button-lan.cfg",
     require => Package["nagios3"],
     notify => Service["nagios3"],
   }

file { "/etc/nagios3/conf.d/contacts.cfg":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/check_mk/contacts.cfg",
     require => Package["nagios3"],
     notify => Service["nagios3"],
   }

file { "/etc/nagios3/nagios.cfg":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/check_mk/nagios.cfg",
     require => Package["nagios3"],
     notify => Service["nagios3"],
   }

file { "/etc/nagios3/htpasswd.users":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/check_mk/htpasswd.users",
     require => Package["nagios3"],
     notify => Service["nagios3"],
   }

file { "/etc/nagios3/conf.d/templates.cfg":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/check_mk/templates.cfg",
     require => Package["nagios3"],
     notify => Service["nagios3"],
   }

file { "/etc/nagios3/commands.cfg":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/check_mk/commands.cfg",
     require => Package["nagios3"],
     notify => Service["nagios3"],
   }
}
