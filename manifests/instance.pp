define logstash::instance (
  $ensure=present,
){

  file { "${logstash::etc}/${name}.conf":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template(
      "${logstash::template_path}/${name}-input-${logstash::template_name}.erb",
      "${logstash::template_path}/${name}-filter-${logstash::template_name}.erb",
      "${logstash::template_path}/${name}-output-${logstash::template_name}.erb"),
    notify  => Service["logstash-${name}"],
  }

  logstash::initscript {"logstash-${name}":
    ensure         => $ensure,
    servicename    => "logstash-${name}",
    serviceuser    => $logstash::user,
    servicegroup   => $logstash::group,
    servicehome    => $logstash::home,
    servicelogfile => "${logstash::log}/${name}.log",
    servicejar     => "${logstash::home}/logstash-${logstash::version}-monolithic.jar",
    serviceargs    => "agent -f ${logstash::etc}/${name}.conf -l ${logstash::log}/${name}.log",
    java_home      => $logstash::java_home,
  }

  service {"logstash-${name}":
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
    require   => [
      Package['logstash'],
      Logstash::Initscript["logstash-${name}"]
    ],
  }

}

