# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql::install
class proxysql::install {

  package { 'proxysql':
    ensure => $proxysql::package_ensure,
  }

  file {
    default:
      ensure => directory;

    $proxysql::datadir:
      mode   => $proxysql::datadir_mode;

    $proxysql::logdir:
      mode   => $proxysql::logdir_mode;
  }

}
