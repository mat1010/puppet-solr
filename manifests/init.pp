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
  String $version,
  Variant[Stdlib::HTTPUrl,Stdlib::HTTPSUrl] $mirror,
  Stdlib::Compat::Absolute_path $extract_dir,
  Stdlib::Compat::Absolute_path $var_dir,
  Stdlib::Compat::Absolute_path $solr_home,
  Stdlib::Compat::Absolute_path $log_dir,
  Integer $solr_port,
  String $solr_user,
  Stdlib::Compat::Absolute_path $install_dir,
  Stdlib::Compat::Absolute_path $java_home,
  String $java_mem,
  Boolean $cloud,
  Boolean $upgrade,
  String $zk_ensemble,
  String $zk_chroot,
  Integer $zk_timeout,
  String $solr_host,
  String $solr_time,
  Boolean $enable_remote_jmx,
  String $service_name,
  Stdlib::Compat::Absolute_path $solr_base,
  Optional[Array] $gc_log_opts,
  Optional[Array] $gc_tune,
  Optional[Array] $solr_opts,
) {
  class { '::solr::install': }
  ->class { '::solr::config': }
  ~>class { '::solr::service': }
  ->Class['::solr']
}
