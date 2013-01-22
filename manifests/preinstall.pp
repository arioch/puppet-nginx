# = Class: nginx::preinstall
#
# This class provides anything required by the install class.
# Such as package repositories.
#
class nginx::preinstall {
  if $::nginx::manage_repo {
    case $::operatingsystem {
      'Debian', 'Ubuntu': {
        exec { 'apt-get update':
          command     => 'apt-get update',
          refreshonly => true
        }

        if defined('apt::key') {
          apt::key { '7BD9BF62':
            key_source => 'http://nginx.org/keys/nginx_signing.key',
          }
        }

        if defined('apt::sources_list') {
          # Camp2Camp/apt module
          apt::sources_list { 'nginx':
            ensure  => present,
            source  => false,
            content => "deb http://nginx.org/packages/debian/ ${::lsbdistcodename} nginx",
            notify  => Exec['apt-get update'],
            require => Apt::Key['7BD9BF62'],
          }
        }

        if defined('apt::source') {
          # Puppetlabs/apt module
          apt::source { 'nginx':
            ensure      => present,
            include_src => false,
            location    => 'http://nginx.org/packages/debian',
            release     => $::lsbdistcodename,
            repos       => 'nginx',
            notify      => Exec['apt-get update'],
            require     => Apt::Key['7BD9BF62'],
          }
        }
      }

      default: {
      }
    }
  }
}

