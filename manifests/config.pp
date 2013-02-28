# = Class nginx::config
#
class nginx::config {
  File {
    require => Class['nginx::install'],
    notify  => Service[$nginx::service_name],
  }

  file { $nginx::config_dir:
    ensure => directory;
  }

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      file { $::nginx::vhostdir_enabled:
        ensure => directory;
      }

      if $nginx::status_enable {
        file { "${::nginx::vhostdir_enabled}/status.conf":
          ensure  => present,
          content => template('nginx/status.erb'),
        }
      }
    }

    'Debian', 'Ubuntu': {
      file {
        $::nginx::vhostdir_enabled:
          ensure => directory;

        $::nginx::vhostdir_available:
          ensure => directory;
      }

      if $nginx::status_enable {
        file {
          "${::nginx::vhostdir_available}/status.conf":
            ensure  => present,
            content => template('nginx/status.erb');

          "${::nginx::vhostdir_enabled}/status.conf":
            ensure => link,
            target => "${::nginx::vhostdir_available}/status.conf";
        }
      }
    }

    default: {
      fail "Operatingsystem ${::operatingsystem} is not supported."
    }
  }

  concat { "${::nginx::config_dir}/nginx.conf":
    owner  => $nginx::config_user,
    group  => $nginx::config_group,
    mode   => $nginx::config_mode,
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

    concat::fragment { 'nginx.conf_body_http_footer':
      target  => "${::nginx::config_dir}/nginx.conf",
      content => "}\n\n",
      order   => 15,
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

