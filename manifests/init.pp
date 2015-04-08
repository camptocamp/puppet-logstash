# == Class: logstash
#
# Install logstash.
#
# === Parameters
#
# [*log_dir*]
#   Directory where logstash log file is located.
#
# [*plugins_dir*]
#   Directory where logstash plugins are located.
#
# === Examples
#
# See README
#
class logstash (
  $log_dir      = '/var/log/logstash',
  $plugins_dir  = '/var/lib/logstash/logstash',
) {

  validate_string($::logstash::plugins_dir)
  validate_absolute_path($::logstash::plugins_dir)
  validate_string($::logstash::log_dir)
  validate_absolute_path($::logstash::log_dir)

  anchor { 'logstash::begin': } ->
  class {'::logstash::install': } ->
  anchor { 'logstash::end': }
}
