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
end
