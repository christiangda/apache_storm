require 'spec_helper_acceptance'

describe 'apache_storm class' do

  let(:manifest) {
    <<-EOS
      include ::apache_storm
    EOS
  }

  it 'should run without errors' do
    result = apply_manifest(manifest, 'catch_failures' => true)
    expect("#{result}".exit_code).to eq 2
  end

end
