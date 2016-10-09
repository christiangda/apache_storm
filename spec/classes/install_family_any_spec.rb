require 'spec_helper'

describe 'apache_storm::install', :type => 'class' do

  ['RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux', 'Debian', 'Ubuntu'].each do |distro|

    context "on #{distro} OS" do

      ##########################################################################
      # global vars
      let(:user)  {'storm'}
      let(:group) {'storm'}

      let(:version)       {'1.0.2'}
      let(:repo_base)     {'http://apache.claz.org/storm'}
      let(:package_name)  {'apache-storm'}
      let(:install_path)  {"/opt/#{package_name}"}
      let(:config_path)   {"/etc/#{package_name}"}
      let(:releases_path) {"#{install_path}/releases"}
      let(:sources_path)  {"#{install_path}/sources"}
      let(:logs_path)     {"/var/log/#{package_name}"}
      let(:pid_path)      {"/var/run/#{package_name}"}

      let(:package_release)   {"#{package_name}-#{version}"}
      let(:home)              {"#{releases_path}/#{package_release}"}
      let(:package_file)      {"#{package_release}.tar.gz"}
      let(:package_file_path) {"#{sources_path}/#{package_file}"}
      let(:package_uri)       {"#{repo_base}/#{package_release}/#{package_file}"}

      let(:package_bin_path)           {"#{home}/bin"}
      let(:package_conf_path)          {"#{home}/conf"}
      let(:package_external_path)      {"#{home}/external"}
      let(:package_extlib_path)        {"#{home}/extlib"}
      let(:package_extlib_daemon_path) {"#{home}/extlib-daemon"}
      let(:package_lib_path)           {"#{home}/lib"}
      let(:package_logs_path)          {"#{home}/logs"}
      let(:package_log4j2_path)        {"#{home}/log4j2"}

      let(:install_bin_path)           {"#{install_path}/bin"}
      let(:install_conf_path)          {"#{install_path}/conf"}
      let(:install_external_path)      {"#{install_path}/external"}
      let(:install_extlib_path)        {"#{install_path}/extlib"}
      let(:install_extlib_daemon_path) {"#{install_path}/extlib-daemon"}
      let(:install_lib_path)           {"#{install_path}/lib"}
      let(:install_logs_path)          {"#{install_path}/logs"}
      let(:install_log4j2_path)        {"#{install_path}/log4j2"}

      ##########################################################################
      # Contexts
      context 'Install class tests' do

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('apache_storm::install') }

        it { is_expected.to contain_class('apache_storm') }
        it { is_expected.to contain_class('apache_storm::params') }

        it { is_expected.to contain_package('bash').with( { :ensure => 'present'} ) }
        it { is_expected.to contain_package('wget').with( { :ensure => 'present'} ) }
        it { is_expected.to contain_package('tar').with(  { :ensure => 'present'} ) }

        it { is_expected.to contain_group("#{group}").with({
            :ensure => 'present'
          })
        }
        it { is_expected.to contain_user("#{user}").with({
          :ensure  => 'present',
          :comment => 'Apache Storm User',
          :name    => "#{user}",
          :shell   => '/bin/bash',
          :home    => "#{install_path}",
          :groups  => "#{group}",
          })
        }

        # Fixed Paths and files
        it { is_expected.to contain_file("#{install_path}").with( { :owner => "#{user}", :group => "#{group}" }) }
        it { is_expected.to contain_file("#{releases_path}").with({ :owner => "#{user}", :group => "#{group}" }) }
        it { is_expected.to contain_file("#{sources_path}").with( { :owner => "#{user}", :group => "#{group}" }) }
        it { is_expected.to contain_file("#{pid_path}").with(     { :owner => "#{user}", :group => "#{group}" }) }

        # Download and Install
        it { should contain_exec("download__#{package_file}").with({
          :command => "/usr/bin/wget --no-check-certificate -O #{package_file_path} #{package_uri} 2> /dev/null",
          :creates => "#{package_file_path}",
          :user    => "#{user}"
          })
        }
        it { should contain_exec("extract__#{package_file}").with({
          :command     => "/bin/tar xf #{package_file_path} -C #{releases_path}/ 2> /dev/null",
          :refreshonly => 'true',
          :user        => "#{user}"
          })
        }

        # Create logs directory after uncompress file in release folder
        it { is_expected.to contain_file("#{package_logs_path}").with({
          :ensure => 'directory',
          :mode   => '0644',
          :owner => "#{user}",
          :group => "#{group}"
          })
        }

        # Symbolic links
        it { is_expected.to contain_file("symlink__#{install_bin_path}").with({
          :ensure => 'link',
          :path => "#{install_bin_path}",
          :target => "#{package_bin_path}"
          })
        }
        it { is_expected.to contain_file("symlink__#{install_conf_path}").with({
          :ensure => 'link',
          :path => "#{install_conf_path}",
          :target => "#{package_conf_path}"
          })
        }
        it { is_expected.to contain_file("symlink__#{install_external_path}").with({
          :ensure => 'link',
          :path => "#{install_external_path}",
          :target => "#{package_external_path}"
          })
        }
        it { is_expected.to contain_file("symlink__#{install_extlib_path}").with({
          :ensure => 'link',
          :path => "#{install_extlib_path}",
          :target => "#{package_extlib_path}"
          })
        }
        it { is_expected.to contain_file("symlink__#{install_extlib_daemon_path}").with({
          :ensure => 'link',
          :path => "#{install_extlib_daemon_path}",
          :target => "#{package_extlib_daemon_path}"
          })
        }
        it { is_expected.to contain_file("symlink__#{install_lib_path}").with({
          :ensure => 'link',
          :path => "#{install_lib_path}",
          :target => "#{package_lib_path}"
          })
        }
        it { is_expected.to contain_file("symlink__#{install_logs_path}").with({
          :ensure => 'link',
          :path => "#{install_logs_path}",
          :target => "#{package_logs_path}"
          })
        }
        it { is_expected.to contain_file("symlink__#{logs_path}").with({
          :ensure => 'link',
          :path => "#{logs_path}",
          :target => "#{package_logs_path}"
          })
        }
        it { is_expected.to contain_file("symlink__#{install_log4j2_path}").with({
          :ensure => 'link',
          :path => "#{install_log4j2_path}",
          :target => "#{package_log4j2_path}"
          })
        }

        # Create profile.d file
        it { is_expected.to contain_file("/etc/profile.d/#{package_name}.sh").with({
          :ensure => 'present',
          :mode   => '0644',
          }).with_content(
          /export PATH\=\$PATH\:#{install_path}\/bin\n/
          ) }

      end # en contex init class

    end # contex distro

  end # do distro

end # apache_storm
