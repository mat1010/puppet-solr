# @api private
#
# This class manages the service config.
#
class solr::config {
  # From version 7.4.0 onwards, SOLR uses log4j2.
  if (versioncmp($solr::version, '7.4.0') < 0) {
    $log4jconfig = 'log4j.properties'
    file { "${solr::extract_dir}/solr-${solr::version}/server/resources/${log4jconfig}":
      ensure  => file,
      mode    => '0644',
      owner   => $solr::solr_user,
      group   => $solr::solr_user,
      content => template("solr/${log4jconfig}.erb"),
    }
    file { "${solr::var_dir}/${log4jconfig}":
      ensure  => file,
      mode    => '0644',
      owner   => $solr::solr_user,
      group   => $solr::solr_user,
      content => template("solr/${log4jconfig}.erb"),
    }
  } else {
    $log4jconfig = 'log4j2.xml'
    file { "${solr::extract_dir}/solr-${solr::version}/server/resources/${log4jconfig}":
      ensure  => file,
      mode    => '0644',
      owner   => $solr::solr_user,
      group   => $solr::solr_user,
      content => template("solr/${log4jconfig}.erb"),
    }
    file { "${solr::var_dir}/${log4jconfig}":
      ensure  => file,
      mode    => '0644',
      owner   => $solr::solr_user,
      group   => $solr::solr_user,
      content => template("solr/${log4jconfig}.erb"),
    }
  }

  file { "${solr::var_dir}/solr.in.sh":
    ensure  => file,
    mode    => '0755',
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    content => epp('solr/solr.in.sh.epp'),
  }
  file { "/etc/init.d/${solr::service_name}":
    ensure  => file,
    mode    => '0744',
    content => template('solr/solr.init.erb'),
  }
  ~>exec { 'systemctl daemon-reload # for solr':
    refreshonly => true,
    path        => $::path,
    notify      => Service[$solr::service_name]
  }
}
