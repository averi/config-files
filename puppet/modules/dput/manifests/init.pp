class dput {
        package {
             dput: ensure => present;
        }

file { "dput.cf":
       path => "/etc/dput.cf",
       mode => 644,
       owner => root,
       group => root,
       require => Package["dput"],
       ensure => present,
       source => "puppet:///modules/dput/dput.cf",
     }
}

