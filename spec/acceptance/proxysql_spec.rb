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
    pending { is_expected.to be_installed }
  end

  describe service('proxysql') do
    pending { is_expected.to be_enabled }
    pending { is_expected.to be_running }
  end
end
