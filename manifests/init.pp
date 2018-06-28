# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql
class proxysql (
  String                  $package_ensure,
  Stdlib::Absolutepath    $datadir,
  Stdlib::Filemode        $datadir_mode,
  Stdlib::Absolutepath    $logdir,
  Stdlib::Filemode        $logdir_mode,
  Stdlib::Absolutepath    $configfile,
  String                  $configfile_owner,
  String                  $configfile_group,
  Stdlib::Filemode        $configfile_mode,
  Stdlib::Ensure::Service $service_ensure,
  Boolean                 $service_enable,
  Hash                    $configs,
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
