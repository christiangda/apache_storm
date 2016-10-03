# Class: apache_storm::install
# ===========================
class apache_storm::install inherits apache_storm {
  # Base paths
  $releases_path     = "${install_path}/releases"
  $sources_path      = "${install_path}/sources"

  # Example: http://www.apache.org/dyn/closer.lua/storm/apache-storm-1.0.2/apache-storm-1.0.2.tar.gz
  $package_file      = "${package_name}-${$version}.tar.gz"
  $package_uri       = "${repo}/${package_name}-${$version}/${package_file}"
  $package_file_path = "${sources_path}/${package_file}"


  # Vector with all the paths
  $create_paths = [
    $install_path,
    $releases_path,
    $sources_path,
  ]

  # Install dependecies
  ensure_packages(['bash','wget','tar'], {'ensure' => 'present'}) ~>
  group { $group:
    ensure  => 'present',
  } ~>
  user { $user:
    ensure  => 'present',
    comment => 'Apache Storm User',
    name    => $user,
    shell   => '/bin/bash',
    home    => $install_path,
    groups  => $group,
  } ~>
  file { $create_paths:
    ensure => directory,
    mode   => '0644',
    owner  => $user,
    group  => $group,
  } ~>
  exec { "download__${package_file}":
    command => "/usr/bin/wget -O ${package_file_path}/$package_file ${package_uri} 2> /dev/null",
    creates => $package_file_path,
    timeout => 1800,
    user    => $user,
  } ~>
  exec { "extract__${package_file}":
    command     => "/bin/tar xf ${package_file_path}/$package_file -C ${releases_path}/ 2> /dev/null",
    refreshonly => true,
    user        => $user,
  } ~>
  file { "symlink__${package_file}__bin":
    ensure => 'link',
    path   => "${install_path}/bin",
    target => "${releases_path}/${package_name}-${$version}/bin",
  } ~>
  file { "symlink__${package_file}__conf":
    ensure => 'link',
    path   => "${install_path}/conf",
    target => "${releases_path}/${package_name}-${$version}/conf",
  } ~>
  file { "symlink__${package_file}__external":
    ensure => 'link',
    path   => "${install_path}/external",
    target => "${releases_path}/${package_name}-${$version}/external",
  } ~>
  file { "symlink__${package_file}__extlib":
    ensure => 'link',
    path   => "${install_path}/extlib",
    target => "${releases_path}/${package_name}-${$version}/extlib",
  } ~>
  file { "symlink__${package_file}__extlib-daemon":
    ensure => 'link',
    path   => "${install_path}/extlib-daemon",
    target => "${releases_path}/${package_name}-${$version}/extlib-daemon",
  } ~>
  file { "symlink__${package_file}__lib":
    ensure => 'link',
    path   => "${install_path}/lib",
    target => "${releases_path}/${package_name}-${$version}/lib",
  } ~>
  file { "symlink__${package_file}__log4j2":
    ensure => 'link',
    path   => "${install_path}/log4j2",
    target => "${releases_path}/${package_name}-${$version}/log4j2",
  }
}
