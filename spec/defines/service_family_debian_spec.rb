require 'spec_helper'

describe 'apache_storm::service', :type => 'define' do

  ['Debian', 'Ubuntu'].each do |distro|

    context "on #{distro} OS" do

      let(:facts) { {
        :operatingsystem => distro,
        :kernel          => 'Linux',
        :osfamily        => 'Debian',
        :lsbdistid       => 'Debian'
      } }

      ##########################################################################
      # global vars
      let(:package_name)   {'apache-storm'}
      let(:module_name)   {'apache_storm'}

      ##########################################################################
      # Contexts
      ['nimbus', 'supervisor', 'drpc', 'logviewer', 'ui'].each do |service_name|

        context "using #{service_name}" do

          let(:title)  { "#{service_name}" }
          let(:params) { {
           :manage_service => true,
           :service_ensure => 'present'
          } }

          let(:service_file)          {"/etc/init/#{package_name}-#{service_name}.conf"}
          let(:service_template)      {"#{module_name}/upstart-service.erb"}
          let(:provider)              {'upstart'}
          let(:service_daemon_ensure) {'running'}

          # create systemd file
          it { is_expected.to contain_file("#{service_file}").with({
            :ensure   => 'file',
            :mode     => '0644',
            #:template => "template(#{service_template})", # not supported by rspec-puppet
            })
          }

          # Service
          it { is_expected.to contain_service("#{package_name}-#{service_name}").with({
            :ensure     => "#{service_daemon_ensure}",
            :hasstatus  => true,
            :hasrestart => true,
            :provider   => "#{provider}",
            })
          }

        end # en contex init class

      end # each daemon name

    end # contex distro

  end # do distro

end # apache_storm
