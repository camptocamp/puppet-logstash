# == Class: logstash::config
#
# Setup logstash configuration structure.
#
class logstash::config {

  include concat::setup

  file {[$logstash::home, $logstash::etc, $logstash::log, $logstash::plugins]:
    ensure => 'directory',
    owner  => $logstash::user,
    group  => $logstash::group,
    mode   => '0755',
  }

  file {["${logstash::plugins}/logstash",
    "${logstash::plugins}/logstash/inputs",
    "${logstash::plugins}/logstash/filters",
    "${logstash::plugins}/logstash/outputs"]:
    ensure  => 'directory',
    owner   => $logstash::user,
    group   => $logstash::group,
    mode    => '0755',
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
