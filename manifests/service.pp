# Class: apache_storm::service
# ===========================
define apache_storm::service (
  $manage_service = true,
  $service_ensure = 'present'
) {

  # Validate service name
  if ! ($name in ['nimbus', 'supervisor', 'drpc', 'logviewer', 'ui']) {
    fail('Invalid storm daemon type.  Allowed values are: nimbus, supervisor, drpc, logviewer, ui')
  }

  # Validate manage_service
  validate_bool($manage_service)

  # check valid values for package ensure param
  if ! ($service_ensure in [ 'present', 'installed', 'absent' ]) {
    fail('Invalid ensure value.  Allowed values are: present, installed, absent')
  }

  if $manage_service {

    include apache_storm

    # Vars for template
    $service_name       = $name
    $service_user       = $apache_storm::user
    $service_group      = $apache_storm::group
    $service_home       = $apache_storm::home
    $service_pid_file   = "${apache_storm::pid_path}/${apache_storm::package_name}-${name}.pid"
    $service_log_file   = "${apache_storm::package_logs_path}/${name}.log"
    $command_to_execute = $apache_storm::storm_command

    if $service_ensure == 'absent' {
      $service_ensure_file    = 'absent'
      $service_ensure_symlink = 'absent'
      $service_daemon_ensure  = 'stopped'
    }
    else {
      $service_ensure_file    = 'file'
      $service_ensure_symlink = 'link'
      $service_daemon_ensure  = 'running'
    }

    case $::operatingsystem {
      'RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux': {
        $service_file      = "/lib/systemd/system/${apache_storm::package_name}-${name}.service"
        $service_file_link = "/etc/systemd/system/${apache_storm::package_name}-${name}.service"
        $service_template  = "${module_name}/systemd-service.erb"
        $provider          = 'systemd'

        file { $service_file:
          ensure  => $service_ensure_file,
          mode    => '0644',
          content => template($service_template),
        }

        file { "symlink__${service_file}":
          ensure => $service_ensure_symlink,
          path   => $service_file_link,
          target => $service_file,
        }

        if $service_ensure == 'absent' {
          Service["${apache_storm::package_name}-${name}"] -> File[$service_file] -> File["symlink__${service_file}"]
        }
        else {
          File[$service_file] -> File["symlink__${service_file}"] -> Service["${apache_storm::package_name}-${name}"]
        }

      }
      'Debian', 'Ubuntu': {
        $service_file        = "/etc/init/${apache_storm::package_name}-${name}.conf"
        $service_template = "${module_name}/upstart-service.erb"
        $provider         = 'upstart'

        # https://www.digitalocean.com/community/tutorials/the-upstart-event-system-what-it-is-and-how-to-use-it
        file { $service_file:
          ensure  => $service_ensure_file,
          mode    => '0644',
          content => template($service_template),
        }

        if $service_ensure == 'absent' {
          Service["${apache_storm::package_name}-${name}"] -> File[$service_file]
        }
        else {
          File[$service_file] -> Service["${apache_storm::package_name}-${name}"]
        }

      }
      default: {
        fail("\"${module_name}\" provides no service manage for \"${::operatingsystem}\"")
      }
    }

    service { "${apache_storm::package_name}-${name}":
      ensure     => $service_daemon_ensure,
      name       => "${apache_storm::package_name}-${name}",
      hasstatus  => true,
      hasrestart => true,
      provider   => $provider,
    }
  }

}
