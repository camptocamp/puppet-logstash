define logstash::initscript (
  $ensure,
  $servicename,
  $serviceuser,
  $servicegroup,
  $servicehome,
  $servicelogfile,
  $servicejar,
  $serviceargs,
  $java_home,
) {

  file {"/etc/init.d/${servicename}":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template('logstash/initscript.erb'),
    require => File["/etc/default/${servicename}"],
  }

  file {"/etc/default/${servicename}":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('logstash/init-default.erb'),
  }

}
