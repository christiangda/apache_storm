# Class: apache_storm::service
# ===========================
define apache_storm::service (
  $service = $name,
  $ensure  = 'present'
) {

  # Vars for template
  $service_name       = $service
  $service_user       = $apache_storm::user
  $service_group      = $apache_storm::group
  $service_home       = $apache_storm::params::home
  $service_pid_file   = "${apache_storm::params::pid_path}/${apache_storm::params::package_name}-${service}.pid"
  $service_log_file   = "${apache_storm::params::package_logs_path}/${service}.log"
  $command_to_execute = $apache_storm::params::storm_command

  if $ensure == 'absent' {
    $ensure_file    = 'absent'
    $ensure_symlink = 'absent'
    $service_ensure = 'stopped'
  }
  else {
    $ensure_file    = 'file'
    $ensure_symlink = 'link'
    $service_ensure = 'running'
  }

  case $::operatingsystem {
    'RedHat', 'Fedora', 'CentOS': {
      $service_file      = "/lib/systemd/system/${apache_storm::params::package_name}-${service}.service"
      $service_file_link = "/etc/systemd/system/${apache_storm::params::package_name}-${service}.service"
      $service_template  = "${module_name}/systemd-service.erb"
      $provider          = 'systemd'

      unless $ensure == 'absent' {
        $maxclient = 500
      }

      file { $service_file:
        ensure  => $ensure_file,
        mode    => '0644',
        content => template($service_template),
      }

      file { "symlink__${service_file}":
        ensure => $ensure_symlink,
        path   => $service_file_link,
        target => $service_file,
      }

      if $ensure == 'absent' {
        Service["${apache_storm::params::package_name}-${service}"] -> File[$service_file] -> File["symlink__${service_file}"]
      }
      else {
        File[$service_file] -> File["symlink__${service_file}"] -> Service["${apache_storm::params::package_name}-${service}"]
      }

    }
    'Debian', 'Ubuntu': {
      $service_file      = "/etc/init/${apache_storm::package_name}-${service}.conf"
      $service_template  = "${module_name}/upstart-service.erb"
      $provider          = 'upstart'

      # https://www.digitalocean.com/community/tutorials/the-upstart-event-system-what-it-is-and-how-to-use-it
      file { $service_file:
        ensure  => $ensure_file,
        mode    => '0644',
        content => template($service_template),
      }

      if $ensure == 'absent' {
        Service["${apache_storm::params::package_name}-${service}"] -> File[$service_file]
      }
      else {
        File[$service_file] -> Service["${apache_storm::params::package_name}-${service}"]
      }

    }
    default: {
      fail("\"${module_name}\" provides no service manage for \"${::operatingsystem}\"")
    }
  }

  service { "${apache_storm::params::package_name}-${service}":
    ensure     => $service_ensure,
    hasstatus  => true,
    hasrestart => true,
    provider   => $provider,
  }

}
