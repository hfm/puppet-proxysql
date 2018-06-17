# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql::config
class proxysql::config {

  file { $proxysql::configfile:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('proxysql/proxysql.cnf.epp'),
  }

}
