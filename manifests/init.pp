# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql
class proxysql {

  include proxysql::repo
  include proxysql::install
  include proxysql::service

  Class['::proxysql::repo']
  -> Class['::proxysql::install']
  ~> Class['::proxysql::service']

}
