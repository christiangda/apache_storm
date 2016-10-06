# define: apache_storm::daemon
# ===========================
define apache_storm::daemon (
  $manage_service = false,
  $instances         = {},
) inherits apache_storm {

  validate_hash($instances)

  # create all the directories nedeed by druid in common
  case $name {
    'nimbus': {
      $hash_to_render = merge($default_nimbus_config, $instances)
    }
    'ui': {
      $hash_to_render = merge($default_ui_config, $instances)
    }
    'supervisor': {
      $hash_to_render = merge($default_supervisor_config, $instances)
    }
    'drpc': {
      $hash_to_render = merge($default_drpc_config, $instances)
    }
    'logviewer': {
      $hash_to_render = merge($default_logviewer_config, $instances)
    }
    'all': {
      $level_1 = merge($default_nimbus_config, $instances)
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
