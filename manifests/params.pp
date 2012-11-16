# Class nginx::params
#
#
class nginx::params {
  # Generic parameters
  $logdir = '/var/log/nginx'

  # nginx.conf
  $worker_connections = '1024'
  $worker_priority    = '0'

  # HTTP module
  $default_type      = 'application/octet-stream'
  $gzip              = 'on'
  $keepalive_timeout = '65'
  $mime_types        = '/etc/nginx/mime.types'
  $sendfile          = 'on'
  $tcp_nodelay       = 'on'
  $tcp_nopush        = 'off'

  $server_names_hash_bucket_size = '64'

  # Events module
  $worker_processes = $::processorcount
  $multi_accept     = 'off'

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
      $confdir            = '/etc/nginx'
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
      $confdir            = '/etc/nginx'
      $vhostdir_enabled   = '/etc/nginx/sites-enabled'
      $vhostdir_available = '/etc/nginx/sites-available'
      $pidfile            = '/var/run/nginx.pid'
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
