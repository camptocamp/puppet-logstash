# == Define: logstash::iniscript
#
# A simple wrapper to generate a basic init script
#
define logstash::initscript (
  $ensure,
  $java_opts,
) {

  $logstash_name = $name

  file {"/etc/init.d/logstash-${name}":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template("logstash/initscript.${::osfamily}.erb"),
  }

}
