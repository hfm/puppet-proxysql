# @summary Configure proxysql.cnf
#
# @private
class proxysql::config {

  file { $proxysql::configfile:
    ensure  => file,
    owner   => $proxysql::configfile_owner,
    group   => $proxysql::configfile_group,
    mode    => $proxysql::configfile_mode,
    content => epp('proxysql/proxysql.cnf.epp'),
  }

}
