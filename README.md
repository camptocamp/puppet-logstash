# Logstash Puppet Module

This module is provided by [Camptocamp](http://www.camptocamp.com/)

## Usage

The define type logstash::instance is used to declare one or more [logstash](http://logstash.net/) agents. The names of 
these agents doesn't matter. What is really important is the function of each of these agents 
which consists of specifying inputs, filters, and outputs

    include ::logstash

    logstash::instance{'shipper':
      ensure      => present,
      input_file  => 'puppet:///modules/.../shipper-input',
      filter_file => 'puppet:///modules/.../shipper-filter',
      output_file => 'puppet:///modules/.../shipper-output',
      java_opts   => '-Xms512m -Xmx512m',
    }

    logstash::instance {['indexer-a', 'indexer-b', 'indexer-c']:
      ensure      => present,
      input_file  => 'puppet:///modules/.../indexer-input',
      filter_file => 'puppet:///modules/.../indexer-filter',
      output_file => 'puppet:///modules/.../indexer-output',
      java_opts   => '-Xms1g -Xmx1g',
    }

## Contributing

Please report bugs and feature request using [GitHub issue
tracker](https://github.com/camptocamp/puppet-logstash/issues).

For pull requests, it is very much appreciated to check your Puppet manifest
with [puppet-lint](https://github.com/camptocamp/puppet-logstash/issues) to follow the recommended Puppet style guidelines from the
[Puppet Labs style guide](http://docs.puppetlabs.com/guides/style_guide.html).

## License

Copyright (c) 2013 <mailto:puppet@camptocamp.com> All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
