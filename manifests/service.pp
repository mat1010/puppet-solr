# @api private
#
# This class ensures that the service is running.
#
class solr::service {
  service { $::solr::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
