class offlineimap {

$gmailPassword = extlookup('gmailPassword')

    package { offlineimap:
        ensure => installed,
    }

file { "/home/and/.offlineimaprc":
     owner   => "and",
     group   => "and",
     mode    => 600,
     content => template("offlineimap/offlineimaprc.erb"),
   }
}
