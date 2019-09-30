# == Class: solr
#
# Full description of class solr here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class solr (
  $version           = $::solr::params::version,
  $mirror            = $::solr::params::mirror,
  $extract_dir       = $::solr::params::extract_dir,
  $var_dir           = $::solr::params::var_dir,
  $solr_home         = $::solr::params::solr_home,
  $log_dir           = $::solr::params::log_dir,
  $solr_port         = $::solr::params::solr_port,
  $solr_user         = $::solr::params::solr_user,
  $install_dir       = $::solr::params::install_dir,
  $java_home         = $::solr::params::java_home,
  $java_mem          = $::solr::params::java_mem,
  $cloud             = $::solr::params::cloud,
  $upgrade           = $::solr::params::upgrade,
  $zk_ensemble       = $::solr::params::zk_ensemble,
  $zk_chroot         = $::solr::params::zk_chroot,
  $zk_timeout        = $::solr::params::zk_timeout,
  $solr_host         = $::solr::params::solr_host,
  $solr_time         = $::solr::params::solr_time,
  $enable_remote_jmx = $::solr::params::enable_remote_jmx,
  $service_name      = $::solr::params::service_name,
  $solr_base         = $::solr::params::solr_base,
  Optional[Array] $gc_log_opts = $::solr::params::gc_log_opts,
  Optional[Array] $gc_tune = $::solr::params::gc_tune,
  Optional[Array] $solr_opts = undef,
) inherits ::solr::params {

  validate_string( $version )
  validate_string( $mirror )
  validate_absolute_path( $extract_dir )
  validate_absolute_path( $var_dir )
  validate_absolute_path( $solr_home )
  validate_absolute_path( $log_dir )
  validate_string( $solr_port )
  validate_string( $solr_user )
  validate_absolute_path( $install_dir )
  validate_absolute_path( $solr_base )
  validate_string( $zk_ensemble )
  validate_string( $zk_chroot )
  validate_string( $zk_timeout )
  validate_string( $solr_host )
  validate_string( $solr_time )
  validate_bool( $upgrade )
  validate_bool( $enable_remote_jmx )

  class { '::solr::install': } ->
  class { '::solr::config': } ~>
  class { '::solr::service': } ->
  Class['::solr']
}
