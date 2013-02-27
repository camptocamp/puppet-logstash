define logstash::initscript (
  $ensure,
  $java_opts,
) {

  $logstash_name = $name

  case $::osfamily {
    'RedHat': {
      $service_jar = "${::logstash::home}/logstash-${::logstash::version}-monolithic.jar"
      $service_args = "agent -f ${logstash::etc}/${name}.conf -l ${log_file}"
    }
  }
      
  file {"/etc/init.d/logstash-${name}":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template("logstash/initscript.${::osfamily}.erb"),
  }

}
