class logstash ( 
  $home    = '/usr/share/logstash',
  $etc     = '/etc/logstash',
  $log     = '/var/log/logstash',
  $user    = 'logstash',
  $group   = 'logstash',
) {

  class {'logstash::install': } ->
  class {'logstash::config': } ->
  Logstash::Instance <| |>

}
