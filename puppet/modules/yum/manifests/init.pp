class yum::repo::epel5 {
    file { '/etc/yum.repos.d/epel5.repo':
        source => 'puppet:///modules/yum/epel5.repo'
    }
}

class yum::repo::epel6 {
    file { '/etc/yum.repos.d/epel6.repo':
        source => 'puppet:///modules/yum/epel6.repo'
    }
}

