class xinetd {
    package { 'xinetd':
        ensure => installed,
    }

    service { 'xinetd':
        enable    => true,
        ensure    => running,
        hasstatus => true,
        require   => Package['xinetd'];
    }
}

class xinetd::check_mk {

file { "/etc/xinetd.d/check_mk":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/xinetd/check_mk",
   }
}
