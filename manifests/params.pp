# = Class nginx::params
#
class nginx::params {
  $manage_repo = false

  # Generic parameters
  $http   = true
  $logdir = '/var/log/nginx'
  $mail   = false

  # nginx.conf
  $worker_priority = '0'

  # The number of worker connections should never be higher
  # than the maximum number of open file descriptors.
  if ( $::processorcount * 1024 ) >= 65536 {
    $worker_connections = 61440
  } else {
    $worker_connections = ( 1024 * $::processorcount )
  }

  # HTTP module
  $default_type      = 'application/octet-stream'
  $gzip              = 'on'
  $gzip_disable      = 'MSIE [1-6]\.(?!.*SV1)'
  $keepalive_timeout = '65'
  $mime_types        = '/etc/nginx/mime.types'
  $sendfile          = 'on'
  $tcp_nodelay       = 'on'
  $tcp_nopush        = 'on'

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
