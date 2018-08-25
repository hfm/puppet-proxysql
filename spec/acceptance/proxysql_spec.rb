require 'spec_helper_acceptance'

describe 'proxysql class' do
  let(:manifest) do
    <<-EOS
      include ::proxysql
    EOS
  end

  it 'runs without errors' do
    expect(apply_manifest(manifest, catch_failures: true).exit_code).to eq 2
  end

  it 'runs a second time without changes' do
    expect(apply_manifest(manifest).exit_code).to be_zero
  end

  context 'RedHat', if: os[:family] == 'redhat' do
    describe yumrepo('proxysql') do
      it { is_expected.to exist }
      it { is_expected.to be_enabled }
    end

    describe file('/etc/yum.repos.d/proxysql.repo') do
      it { is_expected.to be_file }
    end
  end

  context 'Debian', if: os[:family] =~ %r{^(ubuntu|debian)$} do
    describe package('lsb-release') do
      it { is_expected.to be_installed }
    end

    describe file('/etc/apt/sources.list.d/proxysql.list') do
      let(:distro) { Specinfra.backend.run_command('lsb_release -s -c').stdout.strip }

      it { is_expected.to be_file }
      its(:content) { is_expected.to match %r{^deb\s+http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/#{distro}\s+\./$} }
    end
  end

  describe package('proxysql') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/proxysql.cnf') do
    it { is_expected.to be_file }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into 'root' }
    it { is_expected.to be_mode 600 }
    its(:content) { is_expected.to match %r{^datadir="/var/lib/proxysql"$} }
  end

  describe file('/var/lib/proxysql') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 700 }
  end

  describe file('/var/log/proxysql') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 700 }
  end

  describe file('/etc/systemd/system/proxysql.service') do
    it { is_expected.to be_file }
    its(:content) { is_expected.to match %r{^ExecStart=/usr/bin/proxysql -f -c /etc/proxysql.cnf$} }
  end

  describe service('proxysql') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running.under('systemd') }
  end

  describe port(6032) do
    it { is_expected.to be_listening.on('0.0.0.0').with('tcp') }
  end

  describe port(6033) do
    it { is_expected.to be_listening.on('0.0.0.0').with('tcp') }
  end
end
