class cron::maild {

file { "mail":
    path    => "/etc/cron.d/mail",
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/cron/mail.cron",
   }
}

class cron::spideroak {

file { "spideroak.cron":
    path    => "/etc/cron.d/spideroak.cron",
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/cron/spideroak.cron",
   }
}

class cron::debomatic {

file { "debomatic":
    path    => "/etc/cron.d/debomatic",
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/cron/debomatic.cron",
   }
}

