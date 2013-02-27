class logstash::params {

  $home = $::osfamily ? {
    'RedHat' => '/usr/local/logstash',
    'Debian' => '/usr/share/logstash',
  }

  $java_home = $::osfamily ? {
    'RedHat' => '/usr/lib/jvm/jre-openjdk',
    'Debian' => '/usr/lib/jvm/default-java',
  }

}
