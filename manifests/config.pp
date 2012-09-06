# = Class nginx::config
class nginx::config {
  file {
    $nginx::confdir:
      ensure => directory;

    $nginx::vhostdir:
      ensure => directory;

    "${nginx::confdir}/nginx.conf":
      ensure  => present,
      content => template('nginx/nginx.conf.erb'),
      owner   => $nginx::config_user,
      group   => $nginx::config_group,
      mode    => $nginx::config_mode,
      require => Class['nginx::install'],
      notify  => Class['nginx::service'];
  }
}
