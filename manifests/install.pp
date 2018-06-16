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
    '/var/lib/proxysql':
      ensure => directory;

    '/var/log/proxysql':
      ensure => directory;
  }

}
