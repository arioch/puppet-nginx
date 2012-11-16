# Class nginx::params
#
#
class nginx::params {
  $logdir             = '/var/log/nginx'
  $default_type       = 'application/octet-stream'
  $mime_types         = '/etc/nginx/mime.types'
  $worker_processes   = $::processorcount
  $worker_connections = '1024'
  $sendfile           = 'on'
  $keepalive_timeout  = '65'
  $tcp_nodelay        = 'on'
  $gzip               = 'on'
  $tcp_nopush         = 'off'

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
      $vhostdir           = '/etc/nginx/conf.d'
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
