# == Class: logstash::config
#
# Setup logstash configuration structure.
#
class logstash::config {

  include concat::setup

  file {[$logstash::home,
         $logstash::etc,
         $logstash::log,
         $logstash::plugins,
        ]:
    ensure => 'directory',
    owner  => $logstash::user,
    group  => $logstash::group,
    mode   => '0755',
  }

  file {["${logstash::home}/logstash/inputs",
         "${logstash::home}/logstash/filters",
         "${logstash::home}/logstash/outputs",
        ]:
    ensure  => 'directory',
    owner   => $logstash::user,
    group   => $logstash::group,
    mode    => '0755',
    recurse => true,
    purge   => true,
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
