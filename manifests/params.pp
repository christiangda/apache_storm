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

  $default_config = {
    'storm.local.dir'        => "${install_path}/local_dir",
    'nimbus.seeds'           => ['localhost'],
    'supervisor.slots.ports' => [{'6700'},{'6701'},{'6702'},{'6703'}],
    'storm.health.check.dir' => 'healthchecks'
    'java.library.path'      => '/usr/local/lib:/opt/local/lib:/usr/lib',
    'storm.cluster.mode'     => 'distributed'
  }
}
