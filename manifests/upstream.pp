# Define: nginx::proxy
# Parameters:
#
define nginx::upstream (
  $upstream_nodes,
  $ensure           = present,
  $ip_hash          = false,
  $upstream_backend = $name
) {

  concat::fragment { "nginx.conf_body_http_upstream_${name}":
    target  => "${nginx::confdir}/nginx.conf",
    content => template('nginx/upstream.erb'),
    order   => 14,
  }

}

