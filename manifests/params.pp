# Class: apache_storm::params
# ===========================
class apache_storm::params {

  $ensure    = 'present'
  $version   = '1.0.2'
  $user      = 'storm'
  $group     = 'storm'
  $repo_base = 'http://apache.claz.org/storm'

  $package_name  = 'apache-storm'
  $install_path  = "/opt/${package_name}"
  $config_path   = "/etc/${package_name}"
  $logs_path     = "/var/log/${package_name}"
  $pid_path      = "/var/run/${package_name}"
  $releases_path = "${install_path}/releases"
  $sources_path  = "${install_path}/sources"

  $package_release   = "${package_name}-${version}"
  $package_file      = "${package_release}.tar.gz"
  $package_uri       = "${repo_base}/${package_release}/${package_file}"
  $package_file_path = "${sources_path}/${package_file}"
  $home              = "${releases_path}/${package_release}"

  $package_bin_path           = "${home}/bin"
  $package_conf_path          = "${home}/conf"
  $package_external_path      = "${home}/external"
  $package_extlib_path        = "${home}/extlib"
  $package_extlib_daemon_path = "${home}/extlib-daemon"
  $package_lib_path           = "${home}/lib"
  $package_logs_path          = "${home}/logs"
  $package_log4j2_path        = "${home}/log4j2"

  $install_bin_path           = "${install_path}/bin"
  $install_conf_path          = "${install_path}/conf"
  $install_external_path      = "${install_path}/external"
  $install_extlib_path        = "${install_path}/extlib"
  $install_extlib_daemon_path = "${install_path}/extlib-daemon"
  $install_lib_path           = "${install_path}/lib"
  $install_logs_path          = "${install_path}/logs"
  $install_log4j2_path        = "${install_path}/log4j2"

  $storm_command              = "${package_bin_path}/storm"

  ##############################################################################
  # Config Hashes
  $default_common_config = {
    'nimbus.seeds'                          => ['localhost'],
    'storm.zookeeper.servers'               => ['localhost'],
    'storm.local.dir'                       => "${install_path}/storm_local_dir",
    'storm.health.check.dir'                => 'healthchecks',
    'java.library.path'                     => '/usr/local/lib:/opt/local/lib:/usr/lib',
    'storm.cluster.mode'                    => 'distributed',

    'nimbus.childopts'                      => '-Xmx256m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8',
    'ui.childopts'                          => '-Xmx768m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8',

    'supervisor.slots.ports'                => [6700, 6701, 6702, 6703],
    'supervisor.childopts'                  => '-Xmx768m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8',
    'drpc.childopts'                        => '-Xmx768m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8',
    'logviewer.childopts'                   => '-Xmx256m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8',
  }
}
