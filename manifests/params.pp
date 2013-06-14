# == Class nginx::params
#
class nginx::params {
  $manage_repo = false

  # Generic parameters
  $access_log    = true
  $http          = true
  $logdir        = '/var/log/nginx'
  $mail          = false
  $status_allow  = '127.0.0.1'
  $status_deny   = 'all'
  $status_enable = true

  # nginx.conf
  $worker_priority = '0'

  # The number of worker connections should never be higher
  # than the maximum number of open file descriptors.
  $worker_connections = 61440

  # HTTP module
  $default_type      = 'application/octet-stream'
  $gzip              = true
  $gzip_comp_level   = '4'
  $gzip_disable      = 'MSIE [1-6]\.(?!.*SV1)'
  $gzip_proxied      = 'any'
  $gzip_static       = true
  $gzip_types        = 'text/plain text/css text/javascript application/json application/x-javascript'
  $keepalive_timeout = '65'
  $mime_types        = '/etc/nginx/mime.types'
  $sendfile          = true
  $tcp_nodelay       = true
  $tcp_nopush        = true

  $proxy_cache           = false
  $proxy_cache_dir       = '/cache'
  $proxy_cache_path      = '/cache/static levels=1:2 keys_zone=staticfilecache:60m inactive=90m max_size=500m'
  $proxy_connect_timeout = '30'
  $proxy_read_timeout    = '120'
  $proxy_send_timeout    = '120'
  $proxy_temp_path       = '/cache/tmp'

  $server_names_hash_bucket_size = '64'

  # Events module
  $accept_mutex     = false
  $multi_accept     = true
  $worker_processes = $::processorcount

  $event_model = $::kernel ? {
    'FreeBSD' => 'kqueue',
    'Linux'   => 'epoll',
    'Solaris' => 'eventport',
    default   => 'select',
  }

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $config_dir          = '/etc/nginx'
      $config_dir_mode     = '0755'
      $config_file_mode    = '0644'
      $config_group        = 'root'
      $config_user         = 'root'
      $daemon_user         = 'nginx'
      $pidfile             = '/var/run/nginx.pid'
      $pkg_ensure          = present
      $pkg_list            = 'nginx'
      $service_enable      = true
      $service_ensure      = 'running'
      $service_hasrestart  = true
      $service_hasstatus   = true
      $service_name        = 'nginx'
      $vhostdir_enabled    = '/etc/nginx/conf.d'
    }

    'Debian', 'Ubuntu': {
      $config_dir          = '/etc/nginx'
      $config_dir_mode     = '0755'
      $config_file_mode    = '0644'
      $config_group        = 'root'
      $config_user         = 'root'
      $daemon_user         = 'www-data'
      $pidfile             = '/var/run/nginx.pid'
      $pkg_ensure          = present
      $pkg_list            = 'nginx'
      $service_enable      = true
      $service_ensure      = 'running'
      $service_hasrestart  = true
      $service_hasstatus   = true
      $service_name        = 'nginx'
      $vhostdir_available  = '/etc/nginx/sites-available'
      $vhostdir_enabled    = '/etc/nginx/sites-enabled'
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}

