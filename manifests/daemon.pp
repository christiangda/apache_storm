# Class: apache_storm::daemon
# ===========================
define apache_storm::daemon (
  $daemon         = $name,
  $manage_service = false,
  $config         = {},
) {

  validate_hash($config)

  # create all the directories nedeed by druid in common
  case $daemon {
    'nimbus': {
      $hash_to_render = merge($::apache_storm::params::default_nimbus_config, $config)
    }
    'ui': {
      $hash_to_render = merge($::apache_storm::params::default_ui_config, $config)
    }
    'supervisor': {
      $hash_to_render = merge($::apache_storm::params::default_supervisor_config, $config)
    }
    'drpc': {
      $hash_to_render = merge($::apache_storm::params::default_drpc_config, $config)
    }
    'logviewer': {
      $hash_to_render = merge($::apache_storm::params::default_logviewer_config, $config)
    }
    default: {
      fail('daemon not supported!')
    }
  }

  # Validate configuration
  validate_hash($hash_to_render)

  # Concatenate new config to main configuration file
  concat::fragment { $daemon:
    ensure  => 'present',
    target  => "${::apache_storm::config_path}/storm.yaml",
    content => template("${module_name}/storm.yaml.erb"),
    order   => 5,
  }

  apache_storm::service{ $daemon: }
}
