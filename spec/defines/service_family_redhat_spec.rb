require 'spec_helper'

describe 'apache_storm::service', :type => 'define' do

  ['RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux'].each do |distro|

    context "on #{distro} OS" do

      let(:facts) { {
        :operatingsystem => distro,
        :kernel => 'Linux',
        :osfamily => 'RedHat'
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

          let(:service_file)          {"/lib/systemd/system/#{package_name}-#{service_name}.service"}
          let(:service_file_link)     {"/etc/systemd/system/#{package_name}-#{service_name}.service"}
          let(:service_template)      {"#{module_name}/systemd-service.erb"}
          let(:provider)              {'systemd'}
          let(:service_daemon_ensure) {'running'}

          # create systemd file
          it { is_expected.to contain_file("#{service_file}").with({
            :ensure   => 'file',
            :mode     => '0644',
            #:template => "template(#{service_template})", # not supported by rspec-puppet
            })
          }

          # Symbolic links
          it { is_expected.to contain_file("symlink__#{service_file}").with({
            :ensure => 'link',
            :path   => "#{service_file_link}",
            :target => "#{service_file}"
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
