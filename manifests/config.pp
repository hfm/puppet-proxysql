# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql::config
class proxysql::config {

  file { $proxysql::configfile:
    ensure  => file,
    owner   => $proxysql::configfile_owner,
    group   => $proxysql::configfile_group,
    mode    => $proxysql::configfile_mode,
    content => epp('proxysql/proxysql.cnf.epp'),
  }

}
