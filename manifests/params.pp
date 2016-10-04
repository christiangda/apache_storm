# Class: apache_storm::params
# ===========================
class apache_storm::params {

  $ensure    = 'present'
  $version   = '1.0.2'
  $user      = 'storm'
  $group     = 'storm'
  $repo_base = 'http://apache.claz.org/storm'

  $package_name  = 'apache-storm'
  $install_path  = "/opt/$package_name"
  $config_path   = "/etc/$package_name"
  $logs_path     = "/var/log/$package_name"
  $pid_path      = "/var/run/$package_name"
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

  ##############################################################################
  # Config Hashes
  $default_common_config = {
    'storm.zookeeper.servers' => ['localhost'],
    'storm.local.dir'         => "${install_path}/strom_local_dir",
    'storm.health.check.dir'  => "healthchecks",
    'java.library.path'       => "/usr/local/lib:/opt/local/lib:/usr/lib",
    'storm.cluster.mode'      => "distributed",
  }

  $default_nimbus_config = {
    'nimbus.seeds'                  => ['localhost'],
    'nimbus.thrift.port'            => 6627,
    'nimbus.thrift.threads'         => 64,
    'nimbus.thrift.max_buffer_size' => 1048576,
    'nimbus.childopts'              => '-Xmx1024m',
  }

  $default_ui_config = {
    'ui.host'            => '0.0.0.0',
    'ui.port'            => '8080',
    'ui.childopts'       => '-Xmx768m',
    'ui.actions.enabled' => true,
  }

  $default_supervisor_config = {
    'supervisor.slots.ports' => [6700, 6701, 6702, 6703],
    'supervisor.childopts'   => '-Xmx256m',
  }

  $default_drpc_config = {
    'drpc.port'                 => 3772,
    'drpc.worker.threads'       => 64,
    'drpc.max_buffer_size'      => 1048576,
    'drpc.queue.size'           => 128,
    'drpc.invocations.port'     => 3773,
    'drpc.invocations.threads'  => 64,
    'drpc.request.timeout.secs' => 600,
    'drpc.childopts'            => '-Xmx768m',
  }

  $default_logviewer_config = {
    'logviewer.port'                        => '8000',
    'logviewer.childopts'                   => '-Xmx128m',
    'logviewer.cleanup.age.mins'            => 10080,
    'logviewer.appender.name'               => 'A1',
    'logviewer.max.sum.worker.logs.size.mb' => 4096,
    'logviewer.max.per.worker.logs.size.mb' => 2048,
  }
}
