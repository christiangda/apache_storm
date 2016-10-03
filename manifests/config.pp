# Class: apache_storm::config
# ===========================
class apache_storm::config inherits apache_storm {

  # Hash to render in template
  $hash_to_render = $config_options
  # create config file
  file { "${config_path}/storm.yaml":
    ensure  => 'present',
    content => template("${module_name}/storm.yaml.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }
}
