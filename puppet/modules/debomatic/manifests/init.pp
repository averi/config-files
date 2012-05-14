class debomatic {
        package {
             debomatic: ensure => present;
        }

file { "/mnt/debomatic":
       ensure => "directory",
       owner   => "and",
       group   => "and",
       mode    => "0644",
     }

service {
      "debomatic":
       ensure => running,
       enable => true,
       hasrestart => true,
       hasstatus => true,
       require => Package["debomatic"]
     }

file { "debomatic.conf":
       path => "/etc/debomatic/debomatic.conf",
       mode => 644,
       owner => root,
       group => root,
       require => Package["debomatic"],
       ensure => present,
       source => "puppet:///modules/debomatic/debomatic.conf",
       notify => Service["debomatic"],
     }

file { "debomatic":
       path => "/etc/init.d/debomatic",
       mode => 755,
       owner => root,
       group => root,
       require => Package["debomatic"],
       ensure => present,
       source => "puppet:///modules/debomatic/debomatic",
       notify => Service["debomatic"],
     }
}

