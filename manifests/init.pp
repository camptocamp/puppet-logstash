class logstash ( 
  $home          = '/usr/share/logstash',
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

  case $::osfamily {
    'RedHat': {
      package {'logstash':
        ensure => latest,
      }
    }
    'Debian': {
      apt::preferences {'logstash':
        pin      => "version ${version}~c2c*",
        priority => 1001,
      }
      package {'logstash':
        ensure  => latest,
        require => Apt::Preferences ['logstash'],
      }
    }
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
