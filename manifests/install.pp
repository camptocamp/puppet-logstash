class logstash::install {

  package {'logstash':
    ensure => present,
  }

}
