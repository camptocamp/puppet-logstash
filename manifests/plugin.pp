# == Define: logstash::plugin
#
# This class install a logstash plugin that can then be used in an
# instance's config.
#
# === Parameters
#
# [*ensure*]
#   Specifies if the plugin is present or absent
#
# [*type*]
#   Plugin type [ input | filter | output ]
#
# [*source*]
#   Source of the plugin data, cannot be specified with *content*
#
# [*content*]
#   Content of the plugin, cannot be specified with *source*
#
# === Examples
#
# logstash::plugin {'mongodb':
#   ensure => present,
#   type   => 'output',
#   source => 'puppet://$module_name/plugins/outputs/mongodb.rb',
# }
#
define logstash::plugin (
  $type,
  $source=undef,
  $content=undef,
) {

  if $source == undef and $content == undef {
    fail "Must pass either \$source or \$content to logstash::plugin[${name}]"
  }
  if $source != undef and $content != undef {
    fail "Must pass only one of \$source or \$content to logstash::plugin[${name}]"
  }
  validate_re ($type, ['^input$','^filter$','^output$'], "\$type must be one of 'input', 'filter', or 'output' in logstash::plugin[${name}]")

  file {"${logstash::plugins}/logstash/${type}s/${name}.rb":
    ensure  => file,
    owner   => $logstash::user,
    group   => $logstash::group,
    source  => $source,
    content => $content,
  }

}
