# = Define nginx::proxy
#
define nginx::proxy (
  $proxy_pass,
  $ensure                  = present,
  $access_log              = true,
  $client_body_buffer_size = '128k',
  $client_max_body_size    = '8m',
  $enable                  = false,
  $listen                  = [ '80', '443' ],
  $proxy_buffers           = '4 32k',
  $proxy_cache_enable      = false,
  $proxy_cache_expires     = '864000',
  $proxy_cache_location    = '~* /.*(jpg|jpeg|png|gif|css|mp3|wav|swf|mov|ico|htm|html)$',
  $proxy_cache_pass        = $proxy_pass,
  $proxy_connect_timeout   = '150',
  $proxy_ignore_headers    = undef,
  $proxy_read_timeout      = '100',
  $proxy_send_timeout      = '100',
  $server_name             = $name,
) {

  if ! $::nginx::http {
    fail 'NGinX http support is not enabled.'
  }

  File {
    owner   => $nginx::user,
    group   => $nginx::group,
    notify  => Service[$nginx::service_name],
    require => Class['::nginx::config'],
  }

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      if $enable {
        file { "${::nginx::vhostdir_enabled}/${name}":
          ensure  => $ensure,
          content => template ('nginx/proxy.erb');
        }
      } else {
        file { "${::nginx::vhostdir_enabled}/${name}":
          ensure  => $ensure,
          content => template ('nginx/proxy.erb');
        }
      }
    }

    'Debian', 'Ubuntu': {
      if $enable {
        file {
          "${::nginx::vhostdir_available}/${name}":
            ensure  => $ensure,
            content => template ('nginx/proxy.erb');
          "${::nginx::vhostdir_enabled}/${name}":
            ensure  => link,
            target  => "${::nginx::vhostdir_available}/${name}";
        }
      } else {
        file {
          "${::nginx::vhostdir_available}/${name}":
            ensure  => $ensure,
            content => template ('nginx/proxy.erb');
          "${::nginx::vhostdir_enabled}/${name}":
            ensure => absent,
        }
      }
    }

    default: {
      fail "Operatingsystem ${::operatingsystem} is not supported."
    }
  }
}

