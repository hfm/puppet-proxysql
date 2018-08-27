# @summary Setup the repository for proxysql
#
# @private
#
class proxysql::repo {

  case $facts['operatingsystem'] {
    'Debian', 'Ubuntu': {
      ensure_packages('lsb-release')

      include ::apt
      require ::apt::update
    }
    'CentOS', 'OracleLinux', 'RedHat', 'Scientific': {
      yumrepo { 'proxysql':
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
