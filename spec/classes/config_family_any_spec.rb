require 'spec_helper'

describe 'apache_storm::config', :type => 'class' do

  ['RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux', 'Debian', 'Ubuntu'].each do |distro|

    context "on #{distro} OS" do

      ##########################################################################
      # global vars
      let(:user)  {'storm'}
      let(:group) {'storm'}

      let(:package_name)  {'apache-storm'}
      let(:config_path)   {"/etc/#{package_name}"}

      ##########################################################################
      # Contexts
      context 'Config class tests' do

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('apache_storm::config') }

        it { is_expected.to contain_class('apache_storm') }
        it { is_expected.to contain_class('apache_storm::params') }

        it { is_expected.to contain_file("#{config_path}/storm.yaml").with({
          :ensure  => 'present',
          :owner   => "#{user}",
          :group   => "#{group}",
          :mode    => '0644'
          })
        }

      end # en contex init class

    end # contex distro

  end # do distro

end # apache_storm
