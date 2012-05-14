class iptables {
    package { iptables:  
        ensure => installed;
    }

case $operatingsystem {
    redhat: {
     service { "iptables":
         ensure    => running,
         hasstatus => true,
         require   => Package["iptables"],
         }
     }
}

#    service { "iptables":
#        ensure    => running,
#        hasstatus => true,
#        require   => Package["iptables"],
#    }
#
#    file { "/etc/sysconfig/iptables":
#        owner   => "root",
#        group   => "root",
#        mode    => 644,
#        content => template("iptables/iptables.erb"),
#        notify  => Service["iptables"],
#    }

case $operatingsystem {
    redhat: {
     file { [ "/etc/sysconfig/iptables" ]:
        content => template("iptables/iptables.erb"),
        notify => Exec["iptables-$operatingsystem restore"],
          }
    }
    debian: {
     file { [ "/etc/iptables" ]:
        content => template("iptables/iptables.erb"),
        notify => Exec["iptables-$operatingsystem restore"],
          }
    }         
}

exec { "iptables-Debian restore":
    command     => "/sbin/iptables-restore /etc/iptables",
    refreshonly => true
    }

exec { "iptables-RedHat restore":
    command     => "/sbin/iptables-restore /etc/sysconfig/iptables",
    refreshonly => true
    } 
}
