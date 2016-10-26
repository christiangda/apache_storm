require 'spec_helper'

describe 'apache_storm', type: 'class' do

  ['RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux'].each do |distro|

    context "on #{distro} OS" do

      let(:facts) { {
        operatingsystem: distro,
        kernel:          'Linux',
        osfamily:        'RedHat'
      } }


      context 'Init class tests with the default parameters' do

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('apache_storm') }
        it { is_expected.to contain_class('apache_storm::params') }

        it { is_expected.to contain_class('apache_storm::install') }
        it { is_expected.to contain_class('apache_storm::config').that_requires('Class[apache_storm::install]') }

      end # en contex init class

    end # contex distro

  end # do distro

end # apache_storm
