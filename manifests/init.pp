class logstash ( 
  $home          = '/usr/local/logstash',
  $etc           = '/etc/logstash',
  $log           = '/var/log/logstash',
  $user          = 'logstash',
  $group         = 'logstash',
  $version       = '1.1.9',
  $template_path = 'logstash',
  $template_name = 'default',
  $java_home     = '/usr/lib/jvm/jre-openjdk'
) {

  file {$home:
    ensure  => 'directory',
  }

  file {$etc:
    ensure  => 'directory',
  }

  package {'logstash':
    ensure => latest,
  }

  user {$user:
    ensure => present,
    system => true,
  }

}
