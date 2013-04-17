class logstash ( 
  $home    = '/usr/share/logstash',
  $etc     = '/etc/logstash',
  $log     = '/var/log/logstash',
  $user    = 'logstash',
  $group   = 'logstash',
  $version = '1.1.9',
) {

  class {'logstash::install': } ->
  class {'logstash::config': } ->
  Logstash::Instance <| |>

}
