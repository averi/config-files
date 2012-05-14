class imapfilter {

$gmailPassword = extlookup('gmailPassword')

    package { imapfilter:
        ensure => installed,
    }

file { "/home/and/.imapfilter":
       ensure => "directory",
       owner   => "and",
       group   => "and",
       mode    => "0640",
     }

file { "/home/and/.imapfilter/certificates":
     owner   => "and",
     group   => "and",
     mode    => 0640,
     source  => "puppet:///modules/imapfilter/certificates",
   }

file { "/home/and/.imapfilter/imapfilter.lua":
     owner   => "and",
     group   => "and",
     mode    => 600,
     content => template("imapfilter/imapfilter.lua.erb"),
   }
}

