# = Class nginx::config
class nginx::config {
  File {
    require => Class['nginx::install'],
    notify  => Service[$nginx::service_name],
  }

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      file { $nginx::vhostdir:
        ensure => directory;
      }
    }

    'Debian', 'Ubuntu': {
      file {
        $::nginx::vhostdir_enabled:
          ensure => directory;

        $::nginx::vhostdir_available:
          ensure => directory;
      }
    }

    default: {
      fail "Operatingsystem ${::operatingsystem} is not supported."
    }
  }

  file {
    $nginx::confdir:
      ensure => directory;

    "${nginx::confdir}/nginx.conf":
      ensure  => present,
      content => template('nginx/nginx.conf.erb'),
      owner   => $nginx::config_user,
      group   => $nginx::config_group,
      mode    => $nginx::config_mode,
  }
}
