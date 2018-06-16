# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql::install
class proxysql::install {

  package { 'proxysql':
    ensure => installed,
  }

  file {
    $proxysql::datadir:
      ensure => directory;

    $proxysql::logdir:
      ensure => directory;
  }

}
