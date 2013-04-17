class logstash::config {

  include concat::setup

  file {[$logstash::home, $logstash::etc, $logstash::log]:
    ensure => 'directory',
    owner  => $logstash::user,
    group  => $logstash::group,
    mode   => '0755',
  }

  user {$logstash::user:
    ensure => present,
    system => true,
    gid    => $logstash::group
  }

  group {$logstash::group:
    ensure => present,
    system => true,
  }

}
