# == Class nginx::config
#
class nginx::config {
  File {
    mode    => $nginx::config_file_mode,
    notify  => Service[$nginx::service_name],
    require => Class['nginx::install'],
  }

  file { $nginx::config_dir:
    ensure => directory,
    mode   => $nginx::config_dir_mode,
  }

  if $nginx::status_enable {
    file { "${::nginx::config_dir}/conf.d/status.conf":
      ensure  => present,
      content => template('nginx/status.erb'),
    }
  }

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      file { $::nginx::vhostdir_enabled:
        ensure => directory;
      }
    }

    'Debian', 'Ubuntu': {
      file {
        $::nginx::vhostdir_enabled:
          ensure => directory;

        $::nginx::vhostdir_available:
          ensure => directory;
      }
    }

    default: {
      fail "Operatingsystem ${::operatingsystem} is not supported."
    }
  }

  concat { "${::nginx::config_dir}/nginx.conf":
    owner  => $nginx::config_user,
    group  => $nginx::config_group,
    mode   => $nginx::config_file_mode,
    notify => Service[$::nginx::service_name],
  }

  # Default configuration
  concat::fragment { 'nginx.conf_header':
    target  => "${::nginx::config_dir}/nginx.conf",
    content => template('nginx/nginx.conf.erb'),
    order   => 01,
  }

  concat::fragment { 'nginx.conf_body_events_header':
    target  => "${::nginx::config_dir}/nginx.conf",
    content => "events {\n",
    order   => 06,
  }

  concat::fragment { 'nginx.conf_body_events_content':
    target  => "${::nginx::config_dir}/nginx.conf",
    content => template('nginx/events.erb'),
    order   => 07,
  }

  concat::fragment { 'nginx.conf_body_events_footer':
    target  => "${::nginx::config_dir}/nginx.conf",
    content => "}\n\n",
    order   => 10,
  }

  # HTTP module configuration
  if $::nginx::http {
    concat::fragment { 'nginx.conf_body_http_header':
      target  => "${::nginx::config_dir}/nginx.conf",
      content => "http {\n",
      order   => 11,
    }

    concat::fragment { 'nginx.conf_body_http_content':
      target  => "${::nginx::config_dir}/nginx.conf",
      content => template('nginx/http.erb'),
      order   => 12,
    }

    concat::fragment { 'nginx.conf_body_http_includes':
      target  => "${::nginx::config_dir}/nginx.conf",
      content => template('nginx/http_includes.erb'),
      order   => 14,
    }

    concat::fragment { 'nginx.conf_body_http_footer':
      target  => "${::nginx::config_dir}/nginx.conf",
      content => "}\n\n",
      order   => 15,
    }
  }

  if $::nginx::proxy_cache and $::nginx::http {
    $proxy_cache           = $::nginx::proxy_cache
    $proxy_cache_dir       = $::nginx::proxy_cache_dir
    $proxy_cache_path      = $::nginx::proxy_cache_path
    $proxy_connect_timeout = $::nginx::proxy_connect_timeout
    $proxy_read_timeout    = $::nginx::proxy_read_timeout
    $proxy_send_timeout    = $::nginx::proxy_send_timeout
    $proxy_temp_path       = $::nginx::proxy_temp_path

    $_proxy_cache_dir  = regsubst($proxy_cache_dir, '\ .*', '', 'G')
    $_proxy_cache_path = regsubst($proxy_cache_path, '\ .*', '', 'G')
    $_proxy_temp_path  = regsubst($proxy_temp_path, '\ .*', '', 'G')

    file {
      $_proxy_cache_dir:
        ensure => directory,
        owner  => $::nginx::daemon_user,
        group  => $::nginx::daemon_group;

      $_proxy_cache_path:
        ensure  => directory,
        owner   => $::nginx::daemon_user,
        group   => $::nginx::daemon_group,
        require => File[$_proxy_cache_dir];

      $_proxy_temp_path:
        ensure  => directory,
        owner   => $::nginx::daemon_user,
        group   => $::nginx::daemon_group,
        require => File[$_proxy_cache_dir];
    }

    concat::fragment { 'nginx.conf_body_http_caching':
      target  => "${::nginx::config_dir}/nginx.conf",
      content => template('nginx/proxy_cache.erb'),
      order   => 13,
    }
  }

  # Mail module configuration
  if $::nginx::mail {
    concat::fragment { 'nginx.conf_body_mail_header':
      target  => "${::nginx::config_dir}/nginx.conf",
      content => template('nginx/mail_header.erb'),
      order   => 16,
    }

    concat::fragment { 'nginx.conf_body_mail_footer':
      target  => "${::nginx::config_dir}/nginx.conf",
      content => "}\n\n",
      order   => 20,
    }
  }

  # Close header
  concat::fragment { 'nginx.conf_footer':
    target  => "${::nginx::config_dir}/nginx.conf",
    content => "\n",
    order   => 100,
  }
}

