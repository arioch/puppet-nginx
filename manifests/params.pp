# = Class nginx::params
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
  $gzip              = 'on'
  $gzip_comp_level   = '4'
  $gzip_disable      = 'MSIE [1-6]\.(?!.*SV1)'
  $gzip_proxied      = 'any'
  $gzip_static       = 'on'
  $gzip_types        = 'text/plain text/css text/javascript application/json application/x-javascript'
  $keepalive_timeout = '65'
  $mime_types        = '/etc/nginx/mime.types'
  $sendfile          = 'on'
  $tcp_nodelay       = 'on'
  $tcp_nopush        = 'on'

  $proxy_cache           = false
  $proxy_cache_dir       = '/cache'
  $proxy_cache_path      = '/cache/static levels=1:2 keys_zone=staticfilecache:60m inactive=90m max_size=500m'
  $proxy_connect_timeout = '30'
  $proxy_read_timeout    = '120'
  $proxy_send_timeout    = '120'
  $proxy_temp_path       = '/cache/tmp'

  $server_names_hash_bucket_size = '64'

  # Events module
  $accept_mutex     = 'off'
  $multi_accept     = 'on'
  $worker_processes = $::processorcount

  $event_model = $::kernel ? {
    'FreeBSD' => 'kqueue',
    'Linux'   => 'epoll',
    'Solaris' => 'eventport',
    default   => 'select',
  }

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $pkg_ensure         = present
      $pkg_list           = 'nginx'
      $service_name       = 'nginx'
      $service_ensure     = 'running'
      $service_enable     = true
      $service_hasstatus  = true
      $config_user        = 'root'
      $config_group       = 'root'
      $config_mode        = '0644'
      $daemon_user        = 'nginx'
      $config_dir         = '/etc/nginx'
      $vhostdir_enabled   = '/etc/nginx/conf.d'
      $pidfile            = '/var/run/nginx.pid'
    }

    'Debian', 'Ubuntu': {
      $pkg_ensure         = present
      $pkg_list           = 'nginx'
      $service_name       = 'nginx'
      $service_ensure     = 'running'
      $service_enable     = true
      $service_hasstatus  = true
      $config_user        = 'root'
      $config_group       = 'root'
      $config_mode        = '0644'
      $daemon_user        = 'www-data'
      $config_dir         = '/etc/nginx'
      $vhostdir_enabled   = '/etc/nginx/sites-enabled'
      $vhostdir_available = '/etc/nginx/sites-available'
      $pidfile            = '/var/run/nginx.pid'
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}

