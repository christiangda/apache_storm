require 'spec_helper'

describe 'apache_storm::install', :type => 'class' do
  ['RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux', 'Debian', 'Ubuntu'].each do |distro|
    context "on #{distro} OS" do
      ##########################################################################
      # global vars
      let('user')  { 'storm' }
      let('group') { 'storm' }

      let(:version)         { '1.0.2' }
      let(:repo_base)       { 'http://apache.claz.org/storm' }
      let(:package_name)    { 'apache-storm' }
      let(:install_path)    { "/opt/#{package_name}" }
      let(:config_path)     { "/etc/#{package_name}" }
      let(:releases_path)   { "#{install_path}/releases" }
      let(:sources_path)    { "#{install_path}/sources" }
      let(:current_path)    { "#{install_path}/current" }
      let(:logs_path)       { "/var/log/#{package_name}" }
      let(:pid_path)        { "/var/run/#{package_name}" }
      let(:storm_local_dir) { "#{install_path}/storm_local_dir" }

      let(:package_release)   { "#{package_name}-#{version}" }
      let(:releases_home)     { "#{releases_path}/#{package_release}" }
      let(:package_file)      { "#{package_release}.tar.gz" }
      let(:package_file_path) { "#{sources_path}/#{package_file}" }
      let(:package_uri)       { "#{repo_base}/#{package_release}/#{package_file}" }

      let(:package_bin_path)  { "#{releases_home}/bin" }
      let(:package_conf_path) { "#{releases_home}/conf" }
      let(:package_logs_path) { "#{releases_home}/logs" }

      ##########################################################################
      # Contexts
      context 'Install class tests' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('apache_storm::install') }
        it { is_expected.to contain_class('apache_storm') }
        it { is_expected.to contain_class('apache_storm::params') }

        it do
          is_expected.to contain_group("#{group}").with(
            'ensure' => 'present'
          )
        end

        it do
          is_expected.to contain_user("#{user}").with(
            'ensure'  => 'present',
            'comment' => 'Apache Storm User',
            'name'    => "#{user}",
            'shell'   => '/bin/bash',
            'home'    => "#{install_path}",
            'groups'  => "#{group}"
          )
        end

        # Fixed Paths and files
        it do
          is_expected.to contain_file("#{install_path}").with(
            'ensure' => 'directory',
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end

        it do
          is_expected.to contain_file("#{releases_path}").with(
            'ensure' => 'directory',
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end

        it do
          is_expected.to contain_file("#{sources_path}").with(
            'ensure' => 'directory',
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end

        it do
          is_expected.to contain_file("#{pid_path}").with(
            'ensure' => 'directory',
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end

        it do
          is_expected.to contain_file("#{storm_local_dir}").with(
            'ensure' => 'directory',
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end

        # neccesary packages
        it { is_expected.to contain_package('install__wget').with( 'ensure' => 'installed' ) }

        # Download and Install
        it do
          should contain_exec("download__#{package_file}").with(
            'command' => "/usr/bin/wget --no-check-certificate -O #{package_file_path} #{package_uri} 2> /dev/null",
            'creates' => "#{package_file_path}",
            'user'    => "#{user}"
          )
        end

        it do
          should contain_exec("extract__#{package_file}").with(
            'command'     => "/bin/tar xf #{package_file_path} -C #{releases_path}/ 2> /dev/null",
            'refreshonly' => 'true',
            'user'        => "#{user}"
          )
        end

        # Create logs directory after uncompress file in release folder
        it do
          is_expected.to contain_file("#{package_logs_path}").with(
            'ensure' => 'directory',
            'mode'   => '0644',
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end

        # Symbolic links
        it do
          is_expected.to contain_file("symlink__#{current_path}").with(
            'ensure' => 'link',
            'path'   => "#{current_path}",
            'target' => "#{releases_home}",
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end

        it do
          is_expected.to contain_file("symlink__#{config_path}").with(
            'ensure' => 'link',
            'path'   => "#{config_path}",
            'target' => "#{package_conf_path}",
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end

        it do
          is_expected.to contain_file("symlink__#{logs_path}").with(
            'ensure' => 'link',
            'path'   => "#{logs_path}",
            'target' => "#{package_logs_path}",
            'owner'  => "#{user}",
            'group'  => "#{group}"
          )
        end
        # Create profile.d file
        it do
          is_expected.to contain_file("/etc/profile.d/#{package_name}.sh").with(
            'ensure' => 'present',
            'mode'   => '0644',
            'owner'  => "#{user}",
            'group'  => "#{group}"
          ).with_content(
            /export PATH\=\$PATH\:#{current_path}\/bin\n/
          )
        end
      end # en contex init class
    end # contex distro
  end # do distro
end # apache_storm
