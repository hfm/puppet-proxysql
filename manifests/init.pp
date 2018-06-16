# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql
class proxysql (
  Stdlib::Absolutepath $configfile,
  Stdlib::Absolutepath $datadir,
  Stdlib::Absolutepath $logdir,
) {

  include proxysql::repo
  include proxysql::install
  include proxysql::config
  include proxysql::service

  Class['::proxysql::repo']
  -> Class['::proxysql::install']
  -> Class['::proxysql::config']
  ~> Class['::proxysql::service']

}
