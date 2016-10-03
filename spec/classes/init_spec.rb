require 'spec_helper'
describe 'apache_storm' do

  context 'with defaults for all parameters' do
    it { should contain_class('apache_storm') }
  end
end
