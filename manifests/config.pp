# Class: apache_storm::config
# ===========================
class apache_storm::config inherits apache_storm {

  # Hash to render in template
  $hash_to_render = $::apache_storm::config_options

  # create config file
  file { "${::apache_storm::config_path}/storm.yaml":
    ensure  => $::apache_storm::ensure,
    content => template("${module_name}/storm.yaml.erb"),
    owner   => $::apache_storm::user,
    group   => $::apache_storm::group,
    mode    => '0644',
  }
}
