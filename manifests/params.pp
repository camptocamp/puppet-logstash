class logstash::params {

  $java_home = $::osfamily ? {
    'RedHat' => '/usr/lib/jvm/jre-openjdk',
    'Debian' => '/usr/lib/jvm/default-java',
  }

}
