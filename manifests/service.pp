# Class: apache_storm::service
# ===========================
define apache_storm::service (
  $service    = $name,
  $config     = {},
) {

  validate_hash($config)

  # create all the directories nedeed by druid in common
  case $service {
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
      fail('Service not supported!')
    }
  }

  validate_hash($hash_to_render)

  concat::fragment { $service:
    ensure  => 'present',
    target  => "${::apache_storm::config_path}/storm.yaml",
    content => template("${module_name}/storm.yaml.erb"),
    order   => 5,
  }
}
