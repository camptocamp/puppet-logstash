# Logstash Puppet Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/camptocamp/logstash.svg)](https://forge.puppetlabs.com/camptocamp/logstash)
[![Build Status](https://travis-ci.org/camptocamp/puppet-logstash.png?branch=master)](https://travis-ci.org/camptocamp/puppet-logstash)

# Warning

This module is not supported anymore by camptocamp.
Please use [elasticsearch/logstash](https://forge.puppetlabs.com/elasticsearch/logstash) module instead.

This module is provided by [Camptocamp](http://www.camptocamp.com/)

## Usage

Defined type logstash::instance is used to declare one or more [logstash](http://logstash.net/) agents. The names of 
these agents doesn't matter. What is really important is the function of each of these agents 
which consists of specifying inputs, filters, and outputs.

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

## Package

Packages used by this module are simply built with [fpm] (https://github.com/jordansissel/fpm).

Download the all inclusive logstash jar in a basic structure:

    mkdir -p logstash-build/usr/share/logstash
    curl -o logstash-build/usr/share/logstash/logstash.jar http://semicomplete.com/files/logstash/logstash-1.1.9-flatjar.jar

Run the following command for CentOS/RedHat:

    fpm -s dir -t rpm -n logstash -v 1.1.9 -a noarch --iteration 1 --description "Logstash Open Source Log Management" -d "jre >= 1.6.0" -f -C logstash-build .

And this one for Debian/Ubuntu:

    fpm -s dir -t deb -n logstash -v 1.1.9 -a all --iteration 1 --description "Logstash Open Source Log Management" -d "java6-runtime" -f -C logstash-build .
 
## Contributing

Please report bugs and feature request using [GitHub issue
tracker](https://github.com/camptocamp/puppet-logstash/issues).

For pull requests, it is very much appreciated to check your Puppet manifest
with [puppet-lint](http://puppet-lint.com/) to follow the recommended Puppet style guidelines from the
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
