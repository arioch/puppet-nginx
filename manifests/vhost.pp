# = Define nginx::vhost
#
define nginx::vhost (
  $ensure      = present,
  $server_name = $name,
  $config_path = undef,
  $listen      = [ '80', '443' ]
) {
  File {
    owner   => $::nginx::config_user,
    group   => $::nginx::config_group,
    require => Class['::nginx::config'],
    notify  => Service[$::nginx::service_name],
  }

  if ! $config_path {
    file {
      "${::nginx::vhostdir_enabled}/${name}.conf":
        ensure  => $ensure,
        content => template ('nginx/vhost.conf.erb');

    }
  } else {
    # config provided by application
    file { "${::nginx::vhostdir_enabled}/${name}.conf":
        ensure => link,
        target => $config_path,
      }
    }
}
