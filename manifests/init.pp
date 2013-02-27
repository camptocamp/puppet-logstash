class logstash ( 
  $home          = $logstash::params::home,
  $etc           = '/etc/logstash',
  $log           = '/var/log/logstash',
  $user          = 'logstash',
  $group         = 'logstash',
  $version       = '1.1.9',
  $template_path = 'logstash',
  $template_name = 'default',
  $java_home     = $logstash::params::java_home,
) inherits logstash::params {

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
