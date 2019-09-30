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
  $version,
  $mirror,
  $extract_dir,
  $var_dir,
  $solr_home,
  $log_dir,
  $solr_port,
  $solr_user,
  $install_dir,
  $java_home,
  $java_mem,
  $cloud,
  $upgrade,
  $zk_ensemble,
  $zk_chroot,
  $zk_timeout,
  $solr_host,
  $solr_time,
  $enable_remote_jmx,
  $service_name,
  $solr_base,
  Optional[Array] $gc_log_opts,
  Optional[Array] $gc_tune,
  Optional[Array] $solr_opts,
) {

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

  class { '::solr::install': }
  ->class { '::solr::config': }
  ~>class { '::solr::service': }
  ->Class['::solr']
}
