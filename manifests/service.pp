# Class: apache_storm::service
# ===========================
define apache_storm::service (
  $service = $name,
  $ensure  = 'present'
) {

  # Vars for template
  $service_name       = $service
  $service_user       = $::apache_storm::user
  $service_group      = $::apache_storm::group
  $service_home       = $::apache_storm::params::home
  $service_pid_file   = "${::apache_storm::params::pid_path}/${::apache_storm::params::package_name}-${service}.pid"
  $service_log_file   = "${::apache_storm::params::package_logs_path}/${service}.log"
  $command_to_execute = "${::apache_storm::params::package_bin_path}/storm"

  case $::operatingsystem {
    'RedHat', 'Fedora', 'CentOS': {
      $service_file      = "/lib/systemd/system/${::apache_storm::params::package_name}-${service}.service"
      $service_file_link = "/etc/systemd/system/${::apache_storm::params::package_name}-${service}.service"
      $service_template  = "${module_name}/systemd-service.erb"
      $provider          = 'systemd'

      file { $service_file:
        ensure => file,
        mode => '0644',
        content => template($service_template),
      } ~>
      file { "symlink__$service_file":
        ensure => 'link',
        path   => $service_file_link,
        target => $service_file,
      }

    }
    'Debian', 'Ubuntu': {
      $service_file      = "/etc/init/${::apache_storm::package_name}-${service}.conf"
      $service_template  = "${module_name}/upstart-service.erb"
      $provider          = 'upstart'

      # https://www.digitalocean.com/community/tutorials/the-upstart-event-system-what-it-is-and-how-to-use-it
      file { $service_file:
        ensure => file,
        mode => '0644',
        content => template($service_template),
      }

    }
    default: {
      fail("\"${module_name}\" provides no service manage for \"${::operatingsystem}\"")
    }
  }

  service { "${::apache_storm::params::package_name}-${service}":
    ensure     => 'running',
    hasstatus  => true,
    hasrestart => true,
    enable     => $enable,
    provider   => $provider,
    require    => File[$service_file],
  }

}
