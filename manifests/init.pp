# == Class nginx
#
class nginx (
  $accept_mutex                  = $nginx::params::accept_mutex,
  $access_log                    = $nginx::params::access_log,
  $config_dir                    = $nginx::params::config_dir,
  $config_dir_mode               = $nginx::params::config_dir_mode,
  $config_file_mode              = $nginx::params::config_file_mode,
  $config_group                  = $nginx::params::config_group,
  $config_user                   = $nginx::params::config_user,
  $daemon_user                   = $nginx::params::daemon_user,
  $default_type                  = $nginx::params::default_type,
  $event_model                   = $nginx::params::event_model,
  $gzip                          = $nginx::params::gzip,
  $gzip_comp_level               = $nginx::params::gzip_comp_level,
  $gzip_disable                  = $nginx::params::gzip_disable,
  $gzip_proxied                  = $nginx::params::gzip_proxied,
  $gzip_static                   = $nginx::params::gzip_static,
  $gzip_types                    = $nginx::params::gzip_types,
  $http                          = $nginx::params::http,
  $keepalive_timeout             = $nginx::params::keepalive_timeout,
  $logdir                        = $nginx::params::logdir,
  $mail                          = $nginx::params::mail,
  $manage_repo                   = $nginx::params::manage_repo,
  $mime_types                    = $nginx::params::mime_types,
  $multi_accept                  = $nginx::params::multi_accept,
  $pidfile                       = $nginx::params::pidfile,
  $pkg_ensure                    = $nginx::params::pkg_ensure,
  $pkg_list                      = $nginx::params::pkg_list,
  $proxy_cache                   = $nginx::params::proxy_cache,
  $proxy_cache_dir               = $nginx::params::proxy_cache_dir,
  $proxy_cache_path              = $nginx::params::proxy_cache_path,
  $proxy_connect_timeout         = $nginx::params::proxy_connect_timeout,
  $proxy_read_timeout            = $nginx::params::proxy_read_timeout,
  $proxy_send_timeout            = $nginx::params::proxy_send_timeout,
  $proxy_temp_path               = $nginx::params::proxy_temp_path,
  $sendfile                      = $nginx::params::sendfile,
  $server_names_hash_bucket_size = $nginx::params::server_names_hash_bucket_size,
  $service_enable                = $nginx::params::service_enable,
  $service_ensure                = $nginx::params::service_ensure,
  $service_hasrestart            = $nginx::params::service_hasrestart,
  $service_hasstatus             = $nginx::params::service_hasstatus,
  $service_name                  = $nginx::params::service_name,
  $status_allow                  = $nginx::params::status_allow,
  $status_deny                   = $nginx::params::status_deny,
  $status_enable                 = $nginx::params::status_enable,
  $tcp_nodelay                   = $nginx::params::tcp_nodelay,
  $tcp_nopush                    = $nginx::params::tcp_nopush,
  $vhostdir_available            = $nginx::params::vhostdir_available,
  $vhostdir_enabled              = $nginx::params::vhostdir_enabled,
  $worker_connections            = $nginx::params::worker_connections,
  $worker_priority               = $nginx::params::worker_priority,
  $worker_processes              = $nginx::params::worker_processes,
) inherits nginx::params {
  class { 'nginx::preinstall': } ->
  class { 'nginx::install': } ->
  class { 'nginx::config': } ~>
  class { 'nginx::service': } ->
  Class [ 'nginx' ]

  validate_bool($accept_mutex)
  validate_bool($access_log)
  validate_bool($gzip)
  validate_bool($gzip_static)
  validate_bool($http)
  validate_bool($mail)
  validate_bool($manage_repo)
  validate_bool($multi_accept)
  validate_bool($proxy_cache)
  validate_bool($sendfile)
  validate_bool($service_enable)
  validate_bool($service_hasrestart)
  validate_bool($service_hasstatus)
  validate_bool($status_enable)
  validate_bool($tcp_nodelay)
  validate_bool($tcp_nopush)

  validate_absolute_path($logdir)
  validate_absolute_path($mime_types)
  validate_absolute_path($pidfile)
  validate_absolute_path($proxy_temp_path)
  validate_absolute_path($vhostdir_enabled)

  if $vhostdir_available {
    validate_absolute_path($vhostdir_available)
  }
}

