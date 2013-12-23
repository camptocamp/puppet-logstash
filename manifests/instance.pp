# == Define: logstash:instance
#
# This class installs an additional logstash agent.
#
# === Parameters
#
# [*ensure*]
#   Specifies if agent is present or absent
#
# [*java_opts*]
#   JVM runtime parameters.
#
# === Examples
#
# See Readme
#
define logstash::instance (
  $ensure         = present,
  $java_opts      = '-Xms256m -Xmx256m',
  $filter_threads = '1',
) {

  $service_ensure = $ensure ? { present => 'running', default => 'stopped' }
  $service_enable = $ensure ? { present => true, default => false }

  $init_file = "/etc/init.d/logstash-${name}"
  file {$init_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("logstash/initscript.${::osfamily}.erb"),
  }

  $default_path = $::osfamily ? {
    'Debian' => '/etc/default',
    'RedHat' => '/etc/sysconfig',
  }
  $default_file = "${default_path}/logstash-${name}"

  file {$default_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('logstash/default.erb'),
  }

  service {"logstash-${name}":
    ensure    => $service_ensure,
    hasstatus => true,
    enable    => $service_enable,
    require   => [
      Package['logstash'],
    ],
  }

  if $ensure == 'present' {
    File[$init_file] -> File[$default_file] -> Service["logstash-${name}"]
  } else {
    Service["logstash-${name}"] -> File[$default_file] -> File[$init_file]
  }

  file {"/etc/logstash/${name}.conf.d":
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
