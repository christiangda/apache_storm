# Class: apache_storm::params
# ===========================
class apache_storm::params {

  ##############################################################################
  # Globals variables
  $package_name   = 'apache-storm'
  $version        = '1.0.2'
  $user           = 'storm'
  $group          = 'storm'
  $install_path   = "/opt/$package_name"
  $config_path    = "/etc/$package_name"
  $repo           = 'http://ftp.cixug.es/apache/storm'
  $pid_file_path  = '/var/run'

  $releases_path  = "${install_path}/releases"
  $sources_path   = "${install_path}/sources"

  # Example: http://www.apache.org/dyn/closer.lua/storm/apache-storm-1.0.2/apache-storm-1.0.2.tar.gz
  $package_file      = "${package_name}-${$version}.tar.gz"
  $package_uri       = "${repo}/${package_name}-${$version}/${package_file}"
  $package_file_path = "${sources_path}/${package_file}"
  $logs_path         = "${releases_path}/${package_name}-${$version}/logs"
  $home              = "${releases_path}/${package_name}-${$version}"

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
