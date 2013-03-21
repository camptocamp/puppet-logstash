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

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

