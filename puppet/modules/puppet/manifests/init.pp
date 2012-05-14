class puppet::client {
	package {
		"puppet": ensure => present
	}

        service {
                "puppet":
                        ensure => running,
                        enable => true,
                        hasrestart => true,
                        hasstatus => true,
                        require => Package["puppet"]
        }

file { "puppet.conf":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     path    => "/etc/puppet/puppet.conf",
     content => template("puppet/puppet-agent.conf"),
     notify => Service["puppet"],
   }
}

class puppet::server inherits puppet::client {
        package { puppetmaster:
            name => $operatingsystem ? {
                 redhat    => ['puppet-server'],
                 fedora    => ['puppet-server'],
                 debian    => ['puppetmaster'],
                 },
            ensure => installed,
        }
           
        service { puppetmaster:
               ensure => running,
               enable => true,
	       hasrestart => true,
	       hasstatus => true,
	}

File["puppet.conf"] {
	content => template("puppet/puppet-master.conf"),
	notify	=> Service["puppetmaster"],
	require => [ Package[puppet] ],
       }

file { "/etc/puppet/tagmail.conf":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/puppet/tagmail.conf",
     notify	=> Service["puppetmaster"],
   }
}

