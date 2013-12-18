# == Define: logstash::config
#
# Add a configuration file to a logstash instance
#
define logstash::config (
  $type,
  $ensure   = 'present',
  $content  = undef,
  $source   = undef,
  $instance = 'main',
  $order    = '01',
) {

  if $content == undef and $source == undef or $content != undef and $source != undef {
    fail "Must pass (only) one of content or source to logstash::config[${name}]"
  }

  $prefix = $type ? {
    'input'  => '01-input',
    'filter' => '02-filter',
    'output' => '03-output',
  }

  $conf_dir = $instance ? {
    'main'  => 'conf.d',
    default => "${instance}.conf.d",
  }

  $instance_service = $instance ? {
    'main'  => undef,
    default => Service["logstash-${instance}"],
  }

  file {"/etc/logstash/${conf_dir}/${prefix}-${order}-${name}.conf":
    ensure  => $ensure,
    content => $content,
    source  => $source,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => $instance_service,
  }

}
