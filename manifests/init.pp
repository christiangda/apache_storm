# Class: apache_storm
# ===========================
class apache_storm (
  $package_name   = $::apache_storm::params::package_name,
  $version        = $::apache_storm::params::version,
  $user           = $::apache_storm::params::user,
  $group          = $::apache_storm::params::group,
  $install_path   = $::apache_storm::params::install_path,
  $config_path    = $::apache_storm::params::config_path,
  $repo           = $::apache_storm::params::repo,

  $releases_path  = $::apache_storm::params::releases_path,
  $sources_path   = $::apache_storm::params::sources_path,

  $home           = $::apache_storm::params::home,
  $package_file   = $::apache_storm::params::package_file,
  $package_uri    = $::apache_storm::params::package_uri,
  $logs_path      = $::apache_storm::params::logs_path,
  $package_file_path = $::apache_storm::params::package_file_path,

  $config         = {},
  ) inherits apache_storm::params {

  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }
  # Fail fast if we're not using a new apache storm version
  if versioncmp($version, '0.10.0') < 0 {
    fail('This module work only with Apache Storm version > 1.0.0')
  }

  validate_string($package_name)
  validate_absolute_path($install_path)
  validate_absolute_path($config_path)
  validate_absolute_path($releases_path)
  validate_absolute_path($sources_path)
  validate_absolute_path($logs_path)
  validate_hash($config)

  # Variable used to merge configd
  $config_options = merge($::apache_storm::params::default_common_config, $config)
  validate_hash($config_options)

  class { 'apache_storm::install': } ->
  class { 'apache_storm::config': }
}
