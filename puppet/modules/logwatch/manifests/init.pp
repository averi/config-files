class logwatch {
    package { logwatch:  
        ensure => installed;
    }

file { "/usr/share/logwatch/default.conf/logwatch.conf":
     owner   => "root",
     group   => "root",
     mode    => 0644,
     source  => "puppet:///modules/logwatch/logwatch.conf",
   }
}
