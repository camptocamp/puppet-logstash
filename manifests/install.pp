# == Class: logstash::install
#
# This class simply install Logstash
#
class logstash::install {

  package {'logstash':
    ensure => present,
  }

}
