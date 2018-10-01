require 'spec_helper'

describe 'proxysql' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('proxysql') }
      it { is_expected.to contain_class('proxysql::repo') }
      it { is_expected.to contain_class('proxysql::install').that_requires('Class[proxysql::repo]') }
      it { is_expected.to contain_class('proxysql::config').that_requires('Class[proxysql::install]') }
      it { is_expected.to contain_class('proxysql::service').that_requires_to('Class[proxysql::config]') }

      if os_facts[:operatingsystem] =~ %r{Debian|Ubuntu}
        it { is_expected.to contain_package('lsb-release') }
        it { is_expected.not_to contain_yumrepo('proxysql') }
      else
        it { is_expected.not_to contain_package('lsb-release') }
        it { is_expected.to contain_yumrepo('proxysql') }
      end

      it { is_expected.to contain_package('proxysql') }
      it { is_expected.to contain_file('/etc/proxysql.cnf') }
      it { is_expected.to contain_file('/var/lib/proxysql') }
      it { is_expected.to contain_file('/var/log/proxysql') }

      it { is_expected.to contain_service('proxysql') }

      it { is_expected.to contain_systemd__unit_file('proxysql.service') }
      it { is_expected.to contain_systemd__dropin_file('limits.conf') }
    end
  end
end
