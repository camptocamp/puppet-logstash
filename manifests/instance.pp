define logstash::instance (
  $ensure=present,
  $java_opts = '-Xms256m -Xmx256m',
) {

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

  logstash::initscript {"${name}":
    ensure    => $ensure,
    java_opts => $java_opts,
  }

  service {"logstash-${name}":
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
    require   => [
      Package['logstash'],
      File[$logstash::log],
      Logstash::Initscript["${name}"]
    ],
  }

}

