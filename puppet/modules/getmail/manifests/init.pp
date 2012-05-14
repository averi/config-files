class getmail {

$gmailPassword = extlookup('gmailPassword')

    package { getmail:
        name => $operatingsystem ? {
            redhat    => "getmail",
            fedora    => "getmail",
            debian    => "getmail4"
            },
        ensure => installed,
    }

file { "/home/and/.getmail":
       ensure => "directory",
       owner   => "and",
       group   => "and",
       mode    => "0640",
     }

file { "/home/and/.getmail/getmail_run.sh":
     owner   => "and",
     group   => "and",
     mode    => 0770,
     source  => "puppet:///getmail/getmail_run.sh",
   }

file { "/home/and/.getmail/getmailrc":
     owner   => "and",
     group   => "and",
     mode    => 640,
     content => template("getmail/getmailrc.erb"),
   }
}
