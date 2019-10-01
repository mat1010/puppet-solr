# puppet-solr

[![Build Status](https://travis-ci.org/fraenki/puppet-solr.png?branch=master)](https://travis-ci.org/fraenki/puppet-solr)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Usage](#usage)
    - [Beginning with Solr](#beginning-with-solr)
    - [Test Solr](#test-solr)
    - [Solr Cloud](#solr-cloud)
4. [Reference](#reference)
    - [Public classes](#public-classes)
        - [solr](#class-solr)
    - [Private classes](#private-classes)
        - [solr::config](#class-solrconfig)
        - [solr::core](#class-solrcore)
        - [solr::install](#class-solrinstall)
        - [solr::service](#class-solrservice)
5. [Development](#development)
    - [Contributing](#contributing)
6. [License and Copyright](#license-and-copyright)

## Overview

This module will install and configure the Solr search platform.

## Requirements

* Puppet 5 or higher

## Usage

### Beginning with Solr

Install Solr with default settings and start the service afterwards:

    class { 'solr': }

Furthermore, a number of simple options are available:

    class { 'solr':
        # Change version
        version => '8.2.0',

        # Allow automatic upgrades (when changing $version)
        upgrade => true,

        # Network settings
        solr_port => 8983,
        solr_host => $fqdn,

        # Use custom installation and data directories
        extract_dir => '/opt',
        install_dir => '/opt/solr-8.2.0',
        var_dir     => '/opt/solr-home',
        log_dir     => '/opt/solr-home/log',
        solr_home   => '/opt/solr-home/data',

        # Change Solr runtime parameters
        java_mem  => '-Xms2g -Xmx8g',
        solr_time => 'Europe/Berlin',
        solr_opts => [
          '-Duser.language=de',
          '-Duser.country=DE',
        ],

        # Use an alternative download location (for old versions)
        mirror => 'https://archive.apache.org/dist/lucene/solr/',
    }

### Test Solr
Use cURL to test if Solr is running:

    curl -v http://localhost:8983/solr/

(Or use your browser for more convenience.)

### Solr Cloud
This module makes it pretty easy to configure Solr Cloud:

    class { 'solr':
        # Setup Solr cloud
        cloud       => true,
        zk_chroot   => 'foo',
        zk_ensemble => 'zookeeper1.example.com:2181,zookeeper2.example.com:2181,zookeeper3.example.com:2181',
        zk_timeout  => 15000,
    }

It is recommended to use [deric/puppet-zookeeper](https://forge.puppet.com/deric/zookeeper) to manage the ZooKeeper nodes.

## Reference

### Public Classes

#### Class: `solr`

* `cloud`: A flag to indicate if we should enable Solr Cloud. Valid options: `true` and `false`. Default: `false`.
* `enable_remote_jmx`:  A flag to indicate if we should enable remote JMX support. Valid options: `true` and `false`. Default: `false`.
* `extract_dir`: Specifies the directory where the Solr installation archive should be extracted. Default: `/opt`.
* `gc_log_opts`: Specifies the contents of the GC_LOG_OPTS environment variable to enable verbose GC logging. Valid options: an array.
* `gc_tune`: Specifies the contents of the GC_TUNE environment variable to enable custom GC settings. Valid options: an array.
* `java_home`: Specifies the path to a Java installation that should be used by Solr instead of the default. Valid options: an absolute path. Optional.
* `java_mem`: Specifies JVM memory settings that should be used. Valid options: a string. Default: `-Xms512m -Xmx512m`.
* `log_dir`: Specifies the directory for Solr logs. Valid options: an absolute path. Default: `/var/log/solr`.
* `mirror`: Specifies the download location for Solr archives. Valid options: a HTTP(S) URL. Default: `http://www.apache.org/dist/lucene/solr`.
* `service_name`: Specifies the name of the system service that should be setup. Valid options: a string. Default: `solr`.
* `solr_base`: Internal parameter that is automatically generated. Specifies a symlink that is created by the Solr installer. Internal parameter that is automatically composed and must not be changed. Defaults to: `$extract_dir/$service_name`
* `solr_home`: Specifies the Solr data directory. Valid options: an absolute path. Defaults to: `$var_dir/data`.
* `solr_host`: Specifies the hostname that should be used for Solr. Valid options: a string. Defaults to: `$fqdn`.
* `solr_opts`: Specifies optional parameters to customize Solr's startup parameters. Valid options: an array. Optional.
* `solr_port`: Specifies the TCP port that should be used to access the Solr service. Valid options: an integer. Defaults to: `8983`.
* `solr_time`: Specifies the timezone that shoule be used by Solr. Valid options: a string: Defaults to: `UTC`.
* `solr_user`: Specifies the name of the user to use for Solr. Valid options: a string. Default: `solr`.
* `upgrade`: A flag to indicate if Solr should be automatically upgraded to a new version (see `$version`). Valid options: a boolean. Defaults to: `false`.
* `var_dir`: Specifies the base directory for Solr configuration, data and logs. Valid options: an absolute path. Defaults to: `/var/solr`.
* `version`: Specifies the version of Solr that should be installed or the target version for an upgrade (see `$upgrade`). Valid options: a string: Defaults to: `8.2.0`.
* `zk_chroot`: Specifies the ZooKeeper chroot path when using Solr Cloud (see `$cloud`). Valid options: a string. Defaults to: `solrcloud`.
* `zk_ensemble`: Specifies the host:port information for every machine that is part of the ZooKeeper ensemble when using Solr Cloud (see `$cloud`). Valid options: a string. Optional.
* `zk_timeout`: Specifies the timeout (in milliseconds) for connections to machines in the ZooKeeper ensemble. Valid options: an integer. Defaults to: `15000`.

### Private Classes

#### Class: `solr::config`

#### Class: `solr::core`

#### Class: `solr::install`

#### Class: `solr::service`

## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.

## License and Copyright
Copyright (C) 2016-2019 Frank Wall github@moov.de

Copyright (C) 2015-2016 Paul Bailey

See the LICENSE file at the top-level directory of this distribution.
