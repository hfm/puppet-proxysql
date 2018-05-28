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
    describe yumrepo('proxysql_repo') do
      it { should exist }
      it { should be_enabled }
    end

    describe file('/etc/yum.repos.d/stns.repo') do
      it { should be_file }
    end
  end

  context 'Debian', if: os[:family] =~ /^(ubuntu|debian)$/ do
    describe package('lsb-release') do
      it { should be_installed }
    end

    describe file('/etc/apt/sources.list.d/proxysql.list') do
      let(:distro) { Specinfra.backend.run_command('lsb_release -s -c').stdout.strip }

      it { should be_file }
      its(:content) { should match %r{^deb\s+http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/#{distro}\s+\./$} }
    end
  end

  describe package('proxysql') do
    pending { should be_installed }
  end

  describe service('proxysql') do
    pending { should be_enabled }
    pending { should be_running }
  end
end
