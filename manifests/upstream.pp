# Define: nginx::proxy
# Parameters:
#
define nginx::upstream (
  $upstream_nodes,
  $ensure           = present,
  $ip_hash          = true,
  $upstream_backend = $name
) {

  if ! $::nginx::http {
    fail 'NGinX http support is not enabled.'
  }

  if $ensure == present {
    concat::fragment { "nginx.conf_body_http_upstream_${name}":
      target  => "${nginx::config_dir}/nginx.conf",
      content => template('nginx/upstream.erb'),
      order   => 14,
    }
  }

}

