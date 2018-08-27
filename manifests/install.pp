# @summary Install the proxysql package and setup directories.
#
# @private
#
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
