node "mrlawrence" {
    $postfix_host = "mrlawrence"
    $environment = "lockedbox"
    include sudoers
    include openssh-server::mrlawrence
    include users
    include postfix
    include logwatch
    include getmail
    include offlineimap
    include imapfilter
    include cron::maild
#   include cron::spideroak
#   include nfs::client
    include fishpoll::server
    include iptables
    include debomatic
    include dput
    include httpd::debian
    include check_mk::server
    include check_mk::client
    include puppet::server
    include puppet::client
}



