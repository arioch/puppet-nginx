# = Class nginx
#
class nginx (
  $http                          = $nginx::params::http,
  $mail                          = $nginx::params::mail,
  $config_dir                    = $nginx::params::config_dir,
  $config_group                  = $nginx::params::config_group,
  $config_mode                   = $nginx::params::config_mode,
  $config_user                   = $nginx::params::config_user,
  $daemon_user                   = $nginx::params::daemon_user,
  $default_type                  = $nginx::params::default_type,
  $gzip                          = $nginx::params::gzip,
  $keepalive_timeout             = $nginx::params::keepalive_timeout,
  $logdir                        = $nginx::params::logdir,
  $mime_types                    = $nginx::params::mime_types,
  $multi_accept                  = $nginx::params::multi_accept,
  $pidfile                       = $nginx::params::pidfile,
  $pkg_ensure                    = $nginx::params::pkg_ensure,
  $pkg_list                      = $nginx::params::pkg_list,
  $sendfile                      = $nginx::params::sendfile,
  $server_names_hash_bucket_size = $nginx::params::server_names_hash_bucket_size,
  $service_enable                = $nginx::params::service_enable,
  $service_ensure                = $nginx::params::service_ensure,
  $service_hasstatus             = $nginx::params::service_hasstatus,
  $service_name                  = $nginx::params::service_name,
  $tcp_nodelay                   = $nginx::params::tcp_nodelay,
  $tcp_nopush                    = $nginx::params::tcp_nopush,
  $vhostdir_available            = $nginx::params::vhostdir_available,
  $vhostdir_enabled              = $nginx::params::vhostdir_enabled,
  $worker_connections            = $nginx::params::worker_connections,
  $worker_priority               = $nginx::params::worker_priority,
  $worker_processes              = $nginx::params::worker_processes
) inherits nginx::params {

  include nginx::install
  include nginx::config
  include nginx::service

  Class['nginx::install'] ->
  Class['nginx::config'] ->
  Class['nginx::service']

}
