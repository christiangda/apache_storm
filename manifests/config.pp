# Class: apache_storm::config
# ===========================
class apache_storm::config inherits apache_storm {

  # Hash to render in template
  $hash_to_render = $config_options

  # create config file
  concat { "${config_path}/storm.yaml":
    ensure  => $ensure,
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }

  concat::fragment { 'apache-storm-yaml-file':
    ensure  => $ensure,
    target  => "${config_path}/storm.yaml",
    content => template("${module_name}/storm.yaml.erb"),
    order   => 1,
  }
}
