# @summary Configure proxysql.cnf
#
# @private
class proxysql::config {

  file { $proxysql::configfile:
    ensure  => file,
    owner   => $proxysql::owner,
    group   => $proxysql::group,
    mode    => $proxysql::configfile_mode,
    content => epp('proxysql/proxysql.cnf.epp'),
  }

}
