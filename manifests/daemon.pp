# define: apache_storm::daemon
# ===========================
define apache_storm::daemon (
  $daemon         = $name,
  $manage_service = true,
  $ensure         = 'present'
) {

  validate_bool($manage_service)

  # Validate daemon name
  if !($daemon in ['nimbus', 'supervisor', 'drpc', 'logviewer', 'ui']) {
    fail('Invalid storm daemon type.  Allowed values are: nimbus, supervisor, drpc, logviewer, ui')
  }

  # check valid values for package ensure param
  if ! ($ensure in [ 'present', 'installed', 'absent' ]) {
    fail('Invalid ensure value.  Allowed values are: present, installed, absent')
  }

  include ::apache_storm

  if $manage_service {
    apache_storm::service{ $daemon:
      ensure => $ensure,
    }
  }
}
