# == Class: logstash
#
# Base class, which will install logstash. To declare logstash intances use
# defined type `logstash::instance`
#
# === Parameters
#
# [*home*]
#   Directory where logstash jar file is located.
#
# [*etc*]
#   Directory where logstash configuration is located.
#
# [*user*]
#   Default logstash user.
#
# [*group*]
#   Default logstash group.
#
# === Examples
#
# See README
#
class logstash (
  $home    = '/usr/share/logstash',
  $etc     = '/etc/logstash',
  $log     = '/var/log/logstash',
  $user    = 'logstash',
  $group   = 'logstash',
) {

  validate_string($logstash::home)
  validate_absolute_path($logstash::home)
  validate_string($logstash::etc)
  validate_absolute_path($logstash::etc)
  validate_string($logstash::log)
  validate_absolute_path($logstash::log)

  class {'logstash::install': } ->
  class {'logstash::config': } ->
  Logstash::Instance <| |>

}
