class users {
    users::add { "and":
        username        => 'and',
        comment         => 'Andrea Veri',
        shell           => '/bin/bash',
        password_hash   => '8644f32772c276b820f30cceede928df87af16a701e436c9bbd7a729b8bee9cd',
        uid             => 1000,
        gid             => 1000,
    }

define users::add($username, $comment, $shell, $password_hash, $gid, $uid) {
    user { $username:
        ensure => 'present',
        home   => "/home/${username}",
        comment => $comment,
        shell  => $shell,
        managehome => 'true',
        password => $password_hash,
        uid      => $gid,
        gid      => $uid,
    }
  }
}
