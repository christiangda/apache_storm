# Class: apache_storm::install
# ===========================
class apache_storm::install inherits apache_storm {

  # Extract paths from config
  $storm_local_dir = $apache_storm::config_options['storm.local.dir']

  # Vector with all the paths
  $create_paths = [
    $storm_local_dir,
    $apache_storm::install_path,
    $apache_storm::releases_path,
    $apache_storm::sources_path,
    $apache_storm::pid_path,
  ]

  # Install dependecies (OS Independent)
  ensure_packages(['bash','wget','tar'], {'ensure' => 'present'})

  #
  group { $apache_storm::group:
    ensure  => $apache_storm::ensure,
  } ~>
  user { $apache_storm::user:
    ensure  => $apache_storm::ensure,
    comment => 'Apache Storm User',
    name    => $apache_storm::user,
    shell   => '/bin/bash',
    home    => $apache_storm::install_path,
    groups  => $apache_storm::group,
  } ~>
  file { $create_paths:
    ensure => 'directory',
    mode   => '0644',
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  exec { "download__${apache_storm::package_file}":
    command => "/usr/bin/wget --no-check-certificate -O ${apache_storm::package_file_path} ${apache_storm::package_uri} 2> /dev/null",
    creates => $apache_storm::package_file_path,
    timeout => 1800,
    user    => $apache_storm::user,
  } ~>
  exec { "extract__${apache_storm::package_file}":
    command     => "/bin/tar xf ${apache_storm::package_file_path} -C ${apache_storm::releases_path}/ 2> /dev/null",
    refreshonly => true,
    user        => $apache_storm::user,
  } ~>
  file { $apache_storm::package_logs_path:
    ensure => 'directory',
    mode   => '0644',
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::install_bin_path}":
    ensure => 'link',
    path   => $apache_storm::install_bin_path,
    target => $apache_storm::package_bin_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::install_conf_path}":
    ensure => 'link',
    path   => $apache_storm::install_conf_path,
    target => $apache_storm::package_conf_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::config_path}":
    ensure => 'link',
    path   => $apache_storm::config_path,
    target => $apache_storm::package_conf_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::install_external_path}":
    ensure => 'link',
    path   => $apache_storm::install_external_path,
    target => $apache_storm::package_external_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::install_extlib_path}":
    ensure => 'link',
    path   => $apache_storm::install_extlib_path,
    target => $apache_storm::package_extlib_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::install_extlib_daemon_path}":
    ensure => 'link',
    path   => $apache_storm::install_extlib_daemon_path,
    target => $apache_storm::package_extlib_daemon_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::install_lib_path}":
    ensure => 'link',
    path   => $apache_storm::install_lib_path,
    target => $apache_storm::package_lib_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::install_logs_path}":
    ensure => 'link',
    path   => $apache_storm::install_logs_path,
    target => $apache_storm::package_logs_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::logs_path}":
    ensure => 'link',
    path   => $apache_storm::logs_path,
    target => $apache_storm::package_logs_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "symlink__${apache_storm::install_log4j2_path}":
    ensure => 'link',
    path   => $apache_storm::install_log4j2_path,
    target => $apache_storm::package_log4j2_path,
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  } ~>
  file { "/etc/profile.d/${apache_storm::package_name}.sh":
    ensure  => $apache_storm::ensure,
    mode    => '0644',
    content => "export PATH=\$PATH:${apache_storm::install_path}/bin\n",
    owner  => $apache_storm::user,
    group  => $apache_storm::group,
  }
}
