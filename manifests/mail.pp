# = Define nginx::mail
#
define nginx::mail (
  $server_name,
  $ensure         = present,
  $listen_address = 'localhost',
  $listen_port    = undef,
  $protocol       = undef,
  $proxy          = 'on'
) {

  if ! $::nginx::mail {
    fail 'NGinX mail support is not enabled.'
  }

  case $protocol {
    'imap':  {
      if ! $listen_port {
        $_listen_port = '143'
      } else {
        $_listen_port = $listen_port
      }
    }

    'imaps':  {
      if ! $listen_port {
        $_listen_port = '993'
      } else {
        $_listen_port = $listen_port
      }
    }

    'pop3':  {
      if ! $listen_port {
        $_listen_port = '110'
      } else {
        $_listen_port = $listen_port
      }
    }

    'pop3s':  {
      if ! $listen_port {
        $_listen_port = '995'
      } else {
        $_listen_port = $listen_port
      }
    }

    'smtp':  {
      if ! $listen_port {
        $_listen_port = '25'
      } else {
        $_listen_port = $listen_port
      }
    }

    default: {
      if ! $protocol {
        fail "Please specify a protocol for mail proxy ${name}."
      } else {
        fail "Procotol ${protocol} is not supported."
      }
    }
  }

  concat::fragment { "nginx.conf_body_mail_${name}":
    ensure  => $ensure,
    target  => "${nginx::config_dir}/nginx.conf",
    content => template('nginx/mail.erb'),
    order   => 18,
  }
}

