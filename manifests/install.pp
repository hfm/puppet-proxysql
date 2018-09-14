# @summary Install the proxysql package and setup directories.
#
# @private
#
class proxysql::install {

  if $proxysql::owner != 'root' {
    user { $proxysql::owner:
      ensure  => present,
      comment => 'ProxySQL',
      gid     => $proxysql::group,
      home    => $proxysql::datadir,
      shell   => '/bin/false',
      system  => true,
    }
  }

  if $proxysql::group != 'root' {
    group { $proxysql::group:
      ensure => present,
      system => true,
    }
  }

  package { 'proxysql':
    ensure => $proxysql::package_ensure,
  }

  file {
    default:
      ensure => directory,
      owner  => $proxysql::owner,
      group  => $proxysql::group;

    $proxysql::datadir:
      mode   => $proxysql::datadir_mode;

    $proxysql::logdir:
      mode   => $proxysql::logdir_mode;
  }

}
