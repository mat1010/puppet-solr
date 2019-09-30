# == Class solr::params
#
# This class is meant to be called from solr.
# It sets variables according to platform.
#
class solr::params {
  $version           = '5.1.0'
  $mirror            = 'http://www.apache.org/dist/lucene/solr'
  $extract_dir       = '/opt'
  $var_dir           = '/var/solr'
  $solr_home         = "${var_dir}/data"
  $log_dir           = '/var/log/solr'
  $solr_port         = '8983'
  $solr_user         = 'solr'
  $install_dir       = "/opt/solr-${version}"
  $java_home         = undef
  $java_mem          = '-Xms512m -Xmx512m'
  $cloud             = undef
  $zk_ensemble       = undef
  $zk_chroot         = 'solrcloud'
  $zk_timeout        = '15000'
  $solr_host         = $::ipaddress
  $solr_time         = 'UTC'
  $enable_remote_jmx = false
  $upgrade           = false

  $gc_log_opts = [
    '-verbose:gc',
    '-Xlog:gc'
  ]
  $gc_tune = [
    '-XX:NewRatio=3',
    '-XX:SurvivorRatio=4',
    '-XX:TargetSurvivorRatio=90',
    '-XX:MaxTenuringThreshold=8',
    '-XX:+UseConcMarkSweepGC',
    '-XX:ConcGCThreads=4',
    '-XX:ParallelGCThreads=4',
    '-XX:+CMSScavengeBeforeRemark',
    '-XX:PretenureSizeThreshold=64m',
    '-XX:+UseCMSInitiatingOccupancyOnly',
    '-XX:CMSInitiatingOccupancyFraction=50',
    '-XX:CMSMaxAbortablePrecleanTime=6000',
    '-XX:+CMSParallelRemarkEnabled',
    '-XX:+ParallelRefProcEnabled'
  ]

  case $::osfamily {
    'Debian', 'RedHat', 'Amazon': {
      $service_name = 'solr'
      $solr_base    = "${extract_dir}/${service_name}"
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
