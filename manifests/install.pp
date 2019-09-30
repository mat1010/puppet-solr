# == Class solr::install
#
# This class is called from solr for install.
#
class solr::install {

  staging::deploy { "solr-${solr::version}.tgz":
    target       => '/opt/staging',
    source       => "${solr::mirror}/${solr::version}/solr-${solr::version}.tgz",
    staging_path => "/opt/staging/solr-${solr::version}.tgz",
    creates      => "/opt/staging/solr-${solr::version}",
    before       => Augeas['remove service start from SOLR installer'],
  }
  user { $solr::solr_user:
    ensure     => present,
    managehome => true,
    system     => true,
    before     => Exec['run solr install script'],
  }
  if $::solr::upgrade {
    $upgrade_flag = '-f'
  }
  else {
    $upgrade_flag = ''
  }

  # Prevent SOLR installer from starting the service, because puppet needs
  # to create/update the configuration files first.
  $_match_service = 'service "$SOLR_SERVICE" start'
  augeas { 'remove service start from SOLR installer':
    lens    => 'simplelines.lns',
    incl    => "/opt/staging/solr-${solr::version}/bin/install_solr_service.sh",
    changes => "rm *[.='${_match_service}']",
    require => Staging::Deploy["solr-${solr::version}.tgz"],
  } ->
  exec { 'run solr install script':
    command => "/opt/staging/solr-${solr::version}/bin/install_solr_service.sh /opt/staging/solr-${solr::version}.tgz -i ${solr::extract_dir} -d ${solr::var_dir} -u ${solr::solr_user} -s ${solr::service_name} -p ${solr::solr_port} ${upgrade_flag}",
    cwd     => "/opt/staging/solr-${solr::version}",
    creates => "${solr::extract_dir}/solr-${solr::version}",
    require => Staging::Deploy["solr-${solr::version}.tgz"],
  }
  file { $solr::var_dir:
    ensure  => directory,
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    recurse => true,
    require => Exec['run solr install script'],
  }
  file { $solr::log_dir:
    ensure  => directory,
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    require => Exec['run solr install script'],
  }
}
