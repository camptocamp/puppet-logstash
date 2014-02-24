# == Private class: logstash::install
#
# Private logstash installation class.
#
class logstash::install {

  package {'logstash':
    ensure => present,
  }

  file {[$::logstash::plugins_dir,
    "${::logstash::plugins_dir}/inputs",
    "${::logstash::plugins_dir}/filters",
    "${::logstash::plugins_dir}/outputs"]:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => true,
    require => Package['logstash'],
  }

}
