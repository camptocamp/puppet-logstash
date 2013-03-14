class logstash ( 
  $home          = '/usr/share/logstash',
  $etc           = '/etc/logstash',
  $log           = '/var/log/logstash',
  $user          = 'logstash',
  $group         = 'logstash',
  $version       = '1.1.9',
  $template_path = 'logstash',
  $template_name = 'default',
) {

  file {[$home, $etc]:
    ensure => 'directory',
  }

  package {'logstash':
    ensure => ensure,
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
