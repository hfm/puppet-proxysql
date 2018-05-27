# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql::repo
class proxysql::repo {

  case $facts['operatingsystem'] {
    'Debian', 'Ubuntu': {
      include ::apt
    }
    'CentOS', 'OracleLinux', 'RedHat', 'Scientific': {
      yumrepo { 'proxysql_repo':
        baseurl  => 'http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/centos/$releasever',
        descr    => 'ProxySQL YUM repository',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'http://repo.proxysql.com/ProxySQL/repo_pub_key',
      }
    }
    default: {
      fail("${facts['operatingsystem']} is not supported.")
    }
  }

}
