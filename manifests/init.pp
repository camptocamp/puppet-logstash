class logstash ( 
  $home          = '/usr/share/logstash',
  $etc           = '/etc/logstash',
  $log           = '/var/log/logstash',
  $user          = 'logstash',
  $group         = 'logstash',
  $version       = '1.1.9',
) {

  include concat::setup

  file {[$home, $etc]:
    ensure => 'directory',
  }

  package {'logstash':
    ensure => present,
  }

  user {$user:
    ensure => present,
    system => true,
  }

  file {$log:
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0755',
    require => User[$user],
  }

}
