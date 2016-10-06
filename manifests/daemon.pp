# Class: apache_storm::daemon
# ===========================
class apache_storm::daemon (
  $name           = undef,
  $manage_service = true,
  $config         = {},
) inherits apache_storm {

  validate_hash($config)

  # create all the directories nedeed by druid in common
  case $name {
    'nimbus': {
      $hash_to_render = merge($default_nimbus_config, $config)
    }
    'ui': {
      $hash_to_render = merge($default_ui_config, $config)
    }
    'supervisor': {
      $hash_to_render = merge($default_supervisor_config, $config)
    }
    'drpc': {
      $hash_to_render = merge($default_drpc_config, $config)
    }
    'logviewer': {
      $hash_to_render = merge($default_logviewer_config, $config)
    }
    'all': {
      $level_1 = merge($default_nimbus_config, $config)
      $level_2 = merge($default_ui_config, $level_1)
      $level_3 = merge($default_supervisor_config, $level_2)
      $level_4 = merge($default_drpc_config, $level_3)
      $hash_to_render = merge($default_logviewer_config, $level_4)
    }
    default: {
      fail('daemon not supported!')
    }
  }

  # Validate configuration
  validate_hash($hash_to_render)

  # Concatenate new config to main configuration file
  concat::fragment { "${package_name}-${name}":
    ensure  => 'present',
    target  => "${config_path}/storm.yaml",
    content => template("${module_name}/storm.yaml.erb"),
    order   => 50,
  }

  if $manage_service {
    apache_storm::service{ $name: }
  }
}
