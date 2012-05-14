class openssh-server::mrlawrence {

  package { "openssh-server": 
      ensure => "installed",
  }

    service { "ssh":
        ensure    => running,
        hasstatus => true,
        require   => Package["openssh-server"],
    }

augeas { "sshd_config":
  context => "/files/etc/ssh/sshd_config",
    changes => [
    "set ListenAddress 192.168.1.10",
    "set PermitRootLogin no",
    "set RSAAuthentication yes",
    "set PubkeyAuthentication yes",
    "set AuthorizedKeysFile	%h/.ssh/authorized_keys",
    "set PasswordAuthentication no",
    "set Port 222",
  ],
  notify => Service["ssh"],
 }
}

class openssh-server::button {

  package { "openssh-server":
      ensure => "installed",
  }

    service { "sshd":
        ensure    => running,
        hasstatus => true,
        require   => Package["openssh-server"],
    }

augeas { "sshd_config":
  context => "/files/etc/ssh/sshd_config",
    changes => [
    "set ListenAddress 192.168.1.100",
    "set PermitRootLogin no",
    "set RSAAuthentication yes",
    "set PubkeyAuthentication yes",
    "set AuthorizedKeysFile     %h/.ssh/authorized_keys",
    "set PasswordAuthentication no",
    "set Port 2222",
  ],
 notify => Service["sshd"],
 }
}

