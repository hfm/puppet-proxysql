# @summary Install, configures, and manages ProxySQL
#
# @example
#   class { '::proxysql':
#     datadir         => '/var/lib/proxysql',
#     datadir_mode    => '0750',
#     logdir          => '/var/log/proxysql',
#     logdir_mode     => '0750',
#     configs         => {
#       admin_variables => {
#         admin_credentials => 'admin:admin;remoteadmin:remateadminpass',
#         mysql_ifaces      => '0.0.0.0:6032',
#       },
#       mysql_variables => {
#         threads                   => 8,
#         max_connections           => 4096,
#         interfaces                => '0.0.0.0:3306',
#         stacksize                 => 1048576,
#         ping_interval_server_msec => 10000,
#       },
#       mysql_servers => {
#         address   => mysql,
#         port      => 3306,
#         hostgroup => 0,
#       },
#       mysql_users => {
#         username => root,
#       },
#       mysql_query_rules => {
#         rule_id       => 1,
#         active        => 1,
#         match_pattern => '.',
#         log           => 1,
#         apply         => 0,
#       },
#     },
#   }
#
# @see https://github.com/sysown/proxysql/wiki
# @see http://www.proxysql.com/
#
# @param package_ensure
#   What state the package should be in.
# @param datadir
#   The path to the data directory.
# @param datadir_mode
#   The desired permissions mode for the file, in symbolic or numeric notation.
# @param logdir
#   The path to the log directory.
# @param logdir_mode
#   The desired permissions mode for the file, in symbolic or numeric notation.
# @param configfile
#   The path to the default configuration.
# @param configfile_owner
#   The user to whom the file should belong.
# @param configfile_group
#   Which group should own the file.
# @param configfile_mode
#   The desired permissions mode for the file, in symbolic or numeric notation.
# @param service_ensure
#   Whether a service should be running.
# @param service_enable
#   Whether a service should be enabled to start at boot.
# @param configs
#   A hash of parameters for configuring proxysql.cnf. See also https://github.com/sysown/proxysql/wiki/Configuring-ProxySQL
#
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
