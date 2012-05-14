class sudoers {

file { "/etc/sudoers":
      owner   => "root",
      group   => "root",
      mode    => "440",
     }
}

augeas { "addandtosudoers":
  context => "/files/etc/sudoers",
  changes => [
    "set spec[user = 'and']/user and",
    "set spec[user = 'and']/host_group/host ALL",
    "set spec[user = 'and']/host_group/command ALL",
    "set spec[user = 'and']/host_group/command/runas_user ALL",
  ],
}
