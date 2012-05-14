class fishpoll::client {
	package {
		"fishpoke": ensure => present
	}
}

class fishpoll::server {
	package {
		"fishpolld": ensure => present
	}

	service {
		"fishpolld":
			ensure => running,
			enable => true,
			hasrestart => true,
			hasstatus => true,
			require => Package["fishpolld"]
	}

    file { '/etc/fishpoll.d/puppet_remote_update':
                        source => "puppet:///modules/fishpoll/puppet_remote_update",
                        mode => 0644,
                        notify => Service['fishpolld'],
                        require => Package['fishpolld']
    }
}
