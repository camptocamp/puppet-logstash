class logstash::params {

  $java_home = $::osfamily ? {
    'RedHat' => '/usr',
    'Debian' => '/usr/lib/jvm/default-java',
  }

}
