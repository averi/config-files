node "button" {
    $environment = "server"
    $postfix_host = "button"
    httpd::vhost { "sweetrevenge.no-ip.org": name => "sweetrevenge.no-ip.org" }
    include iptables
    include postfix
    include logwatch
    include yum::repo::epel6
#   include nfs::server
    include fishpoll::client
    include openssh-server::button
    include mock
    include cron::debomatic
    include httpd::redhat
    include xinetd
    include check_mk::client
    include nrpe
    include puppet::client
}
