# Class: apache_storm::install
# ===========================
class apache_storm::install inherits apache_storm {

  # Extract paths from config
  $storm_local_dir = $config_options['storm.local.dir']

  # Vector with all the paths
  $create_paths = [
    $storm_local_dir,
    $install_path,
    $releases_path,
    $sources_path,
    $pid_path,
  ]

  # Install dependecies (OS Independent)
  ensure_packages(['bash','wget','tar'], {'ensure' => 'present'})

  #
  group { $group:
    ensure  => $ensure,
  } ~>
  user { $user:
    ensure  => $ensure,
    comment => 'Apache Storm User',
    name    => $user,
    shell   => '/bin/bash',
    home    => $install_path,
    groups  => $group,
  } ~>
  file { $create_paths:
    ensure => 'directory',
    mode   => '0644',
    owner  => $user,
    group  => $group,
  } ~>
  exec { "download__${package_file}":
    command => "/usr/bin/wget -O ${package_file_path} ${package_uri} 2> /dev/null",
    creates => $package_file_path,
    timeout => 1800,
    user    => $user,
  } ~>
  exec { "extract__${package_file}":
    command     => "/bin/tar xf ${package_file_path} -C ${releases_path}/ 2> /dev/null",
    refreshonly => true,
    user        => $user,
  } ~>
  file { $package_logs_path:
    ensure => 'directory',
    mode   => '0644',
    owner  => $user,
    group  => $group,
  } ~>
  file { "symlink__${install_bin_path}":
    ensure => 'link',
    path   => $install_bin_path,
    target => $package_bin_path,
  } ~>
  file { "symlink__${install_conf_path}":
    ensure => 'link',
    path   => $install_conf_path,
    target => $package_conf_path,
  } ~>
  file { "symlink__${config_path}":
    ensure => 'link',
    path   => $config_path,
    target => $package_conf_path,
  } ~>
  file { "symlink__${install_external_path}":
    ensure => 'link',
    path   => $install_external_path,
    target => $package_external_path,
  } ~>
  file { "symlink__${install_extlib_path}":
    ensure => 'link',
    path   => $install_extlib_path,
    target => $package_extlib_path,
  } ~>
  file { "symlink__${install_extlib_daemon_path}":
    ensure => 'link',
    path   => $install_extlib_daemon_path,
    target => $package_extlib_daemon_path,
  } ~>
  file { "symlink__${install_lib_path}":
    ensure => 'link',
    path   => $install_lib_path,
    target => $package_lib_path,
  } ~>
  file { "symlink__${install_logs_path}":
    ensure => 'link',
    path   => $install_logs_path,
    target => $package_logs_path,
  } ~>
  file { "symlink__${logs_path}":
    ensure => 'link',
    path   => $logs_path,
    target => $package_logs_path,
  } ~>
  file { "symlink__${install_log4j2_path}":
    ensure => 'link',
    path   => $install_log4j2_path,
    target => $package_log4j2_path,
  } ~>
  file { '/etc/profile.d/apache-storm.sh':
    ensure  => $ensure,
    mode    => '644',
    content => "export PATH=\$PATH:${install_path}/bin\n",
  }
}
