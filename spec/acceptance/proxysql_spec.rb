require 'spec_helper_acceptance'

describe 'proxysql class' do
  let(:manifest) {
    <<-EOS
      include ::proxysql
    EOS
  }

  it 'should run without errors' do
    expect(apply_manifest(manifest, catch_failures: true).exit_code).to eq 2
  end

  it 'should run a second time without changes' do
    expect(apply_manifest(manifest).exit_code).to be_zero
  end
end
