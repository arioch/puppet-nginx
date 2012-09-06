# = Class nginx
class nginx (
  $logdir             = $nginx::params::logdir,
  $default_type       = $nginx::params::default_type,
  $mime_types         = $nginx::params::mime_types,
  $worker_processes   = $nginx::params::worker_processes,
  $worker_connections = $nginx::params::worker_connections,
  $sendfile           = $nginx::params::sendfile,
  $keepalive_timeout  = $nginx::params::keepalive_timeout,
  $tcp_nodelay        = $nginx::params::tcp_nodelay,
  $gzip               = $nginx::params::gzip,
  $tcp_nopush         = $nginx::params::tcp_nopush,
  $pkg_list           = $nginx::params::pkg_list,
  $pkg_ensure         = $nginx::params::pkg_ensure,
  $service_name       = $nginx::params::service_name,
  $service_ensure     = $nginx::params::service_ensure,
  $service_enable     = $nginx::params::service_enable,
  $service_hasstatus  = $nginx::params::service_hasstatus,
  $confdir            = $nginx::params::confdir,
  $vhostdir           = $nginx::params::vhostdir,
  $config_user        = $nginx::params::config_user,
  $config_group       = $nginx::params::config_group,
  $config_mode        = $nginx::params::config_mode,
  $daemon_user        = $nginx::params::daemon_user,
  $pidfile            = $nginx::params::pidfile
) inherits nginx::params {

  include nginx::install
  include nginx::config
  include nginx::service

  Class['nginx::install'] ->
  Class['nginx::config'] ->
  Class['nginx::service']
}
