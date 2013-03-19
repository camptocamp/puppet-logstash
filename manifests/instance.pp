define logstash::instance (
  $ensure      = present,
  $java_opts   = '-Xms256m -Xmx256m',
  $input_file  = "puppet:///${module_name}/${name}-default-input",
  $filter_file = "puppet:///${module_name}/${name}-default-filter",
  $output_file = "puppet:///${module_name}/${name}-default-output",
) {

  concat {"${logstash::etc}/${name}.conf":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    force   => true,
    notify  => Service["logstash-${name}"],
  }

  concat::fragment {"input-${name}":
    ensure => $ensure,
    target => "${logstash::etc}/${name}.conf",
    source => $input_file,
    order  => 01,
  }

  concat::fragment {"filter-${name}":
    ensure => $ensure,
    target => "${logstash::etc}/${name}.conf",
    source => $filter_file,
    order  => 02,
  }

  concat::fragment {"output-${name}":
    ensure => $ensure,
    target => "${logstash::etc}/${name}.conf",
    source => $output_file,
    order  => 03,
  }

  logstash::initscript {$name:
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
      Logstash::Initscript[$name]
    ],
  }

}

