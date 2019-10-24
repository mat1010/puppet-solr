# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2019-10-24

### Changed
- Use camptocamp/systemd (new dependency) to trigger systemd reloads
- Declare private classes private

### Fixed
- Fix non-zookeeper/cloud installs by making `$zk_ensemble` optional ([#1])

## [2.0.0] - 2019-10-08
This is a feature release that may contain backwards incompatible changes.

### Added
- Add support to manage custom plugins
- Add new parameters: `$custom_plugins`, `$custom_plugins_dir`, `$custom_plugins_id`, `$manage_custom_plugins`
- Add new parameter `$staging_dir` to make the staging directory configurable

### Changed
- Only support Solr 7.x and 8.x (older versions may work but are unsupported)

## [1.0.0] - 2019-10-01
This is the first release after forking the module. It should be possible to
migrate from spacepants/puppet-solr to this version with only minor modifications.

### Added
- Add new parameter `$zk_chroot` to customize the ZooKeeper chroot when using Solr Cloud
- Add new parameter `$enable_remote_jmx` to enable remote JMX support
- Support log4j2 on Solr >= 7.4.0
- Add new parameter `$solr_opts` to customize Solr startup parameters

### Changed
- Style: move parameters to the appropiate location in templates/solr.in.sh.erb
- Various style fixes to make puppet-lint happy
- Make default configuration compatible with JDK 11
- Migrate default settings from params.pp to Hiera module data
- Convert main template to EPP
- Convert module to PDK
- Update depencency and Puppet versions
- Use native Puppet data types
- Update default version to use most recent version of Solr
- Migrate to puppet/archive (replacing nanliu/staging)
- Run Solr installer with new -n parameter for more reliable installation

### Fixed
- Prevent Solr installer from starting an unconfigured instance (fixes a startup error)
- Fix user creation by respecting the `$solr_user` parameter
- Fix copy'n'paste errors in templates/solr.in.sh.erb (checking wrong parameters)
- Reload systemd after changing the init script (fixes a warning message)

### Removed
- Remove unused parameter `$install_dir`
