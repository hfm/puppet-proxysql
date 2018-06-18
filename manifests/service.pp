# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include proxysql::service
class proxysql::service {

  systemd::unit_file { 'proxysql.service':
    content => epp('proxysql/proxysql.service.epp'),
    notify  => Service['proxysql'],
  }

  systemd::dropin_file { 'limits.conf':
    unit    => 'proxysql.service',
    content => "[Service]\nLimitNOFILE=102400\n",
  }

  service { 'proxysql':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
    require  => Class['systemd::systemctl::daemon_reload'],
  }

}
