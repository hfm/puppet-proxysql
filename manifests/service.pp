# @summary Manage service of proxysql
#
# @private
#
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
    ensure   => $proxysql::service_ensure,
    enable   => $proxysql::service_enable,
    provider => 'systemd',
    require  => Class['systemd::systemctl::daemon_reload'],
  }

}
