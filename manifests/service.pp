# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql::service
class proxysql::service {

  service { 'proxysql':
    ensure => running,
    enable => true,
  }

}
