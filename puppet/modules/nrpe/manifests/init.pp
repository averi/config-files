class nrpe {

    case $operatingsystem {
        "Debian":   { include nrpe::debian }
        "RedHat":   { include nrpe::redhat }
    }
}

class nrpe::debian {
    package { nagios-plugins:
        ensure => present
    }

    package { nagios-nrpe-server:
        ensure => present
    }

    service { nagios-nrpe-server: 
        ensure => running,
        enable => true,
        require => Package['nagios-nrpe-server'] 
    }

    file { '/etc/nagios/nrpe_local.cfg':
        source => "puppet:///modules/nrpe/nrpe_local.cfg",
        mode => 0644,
        notify => Service['nagios-nrpe-server'],
        require => Package['nagios-nrpe-server']
    }
}

class nrpe::redhat {
    package {
      nrpe:  ensure => installed;
      nagios-plugins-disk:  ensure => installed;
      nagios-plugins-users:  ensure => installed;
      nagios-plugins-swap:  ensure => installed;
      nagios-plugins-load:  ensure => installed;
      nagios-plugins-ping:  ensure => installed;
      nagios-plugins-procs: ensure => installed;
      nagios-plugins-http: ensure => installed;
      nagios-plugins-ntp: ensure => installed;
      nagios-plugins-ssh: ensure => installed;
      nagios-plugins-nrpe: ensure => installed;
    }

    service { nrpe:
        ensure => running,
        enable => true,
        require => Package['nrpe']
    }

    file { '/etc/nagios/nrpe.cfg':
        source => "puppet:///modules/nrpe/nrpe.cfg",
        mode => 0644,
        notify => Service['nrpe'],
        require => Package['nrpe']
    }

    file { "/etc/nrpe.d":
        ensure => directory,
        recurse => true,
        purge => true,
        force => true,
        owner => "root",
        group => "root",
        mode => 0644,
        notify => Service["nrpe"];
     }

    file { '/etc/nrpe.d/commands.cfg':
        source => "puppet:///modules/nrpe/commands.cfg",
        mode => 0644,
        notify => Service['nrpe'],
        require => Package['nrpe']
    }
}


