# == Define nginx::proxy
#
# === Parameters:
#
# $proxy_pass::               Proxy destination address.
#
# $ensure::                   Default: present
#
# $access_log::               Enable/disable access loggings.
#                             Default: true
#
# $client_body_buffer_size::  Client body buffer size.
#                             Default: 128k
#
# $client_max_body_size::     Client max body size.
#                             Default: 8m
#
# $enable::                   Default: true
#
# $error_log::                Enable/disable error logging.
#                             Default: true
#
# $listen::                   Listen ports, multiple entries accepted in an array.
#                             Default: [ 80, 443 ]
#
# $proxy_buffers::            This directive sets the number and the size of
#                             buffers, into which will be read the answer,
#                             obtained from the proxied server.
#                             Default: 4 32k
#
# $proxy_cache::              This directive sets name of zone for caching.
#                             The same zone can be used in multiple places.
#                             Default: undef
#
# $proxy_cache_enable::       Enable/disable proxy cache.
#                             Default: false
#
# $proxy_cache_expires::      Proxy cache expire ttl.
#                             Default: 864000
#
# $proxy_cache_location::     Which files or directory location to cache.
#                             Default:
#                               ~* /.*(jpg|jpeg|png|gif|css|mp3|wav|swf|mov|ico|htm|html)$
#
# $proxy_cache_pass::         Cached destination address.
#                             Default: $proxy_pass
#
# $proxy_cache_valid::        This directive sets the time for caching replies.
#                             Default: 200 120m
#
# $proxy_connect_timeout::    This directive assigns a timeout for the connection
#                             to the upstream server. It is necessary to keep
#                             in mind that this time out cannot be more than
#                             75 seconds.
#                             Default: 60
#
# $proxy_ignore_headers::     Prohibits the processing of the header lines from
#                             the proxy server's response.
#                             Default: undef
#
# $proxy_read_timeout::       This directive sets the read timeout for the
#                             response of the proxied server. It determines how
#                             long nginx will wait to get the response to a
#                             request. The timeout is established not for entire
#                             response but only between two operations of reading.
#                             Default: 100
#
# $proxy_send_timeout::       This directive assigns timeout with the transfer of
#                             request to the upstream server. Timeout is
#                             established not on entire transfer of request,
#                             but only between two write operations. If after this
#                             time the upstream server will not take new data,
#                             then nginx is shutdown the connection.
#                             Default: 100
#
# $server_name::              Virtualhost server name.
#                             Default: $name
#

define nginx::proxy (
  $proxy_pass,
  $ensure                  = present,
  $access_log              = true,
  $client_body_buffer_size = '128k',
  $client_max_body_size    = '8m',
  $enable                  = true,
  $error_log               = true,
  $listen                  = [ '80', '443' ],
  $proxy_buffers           = '4 32k',
  $proxy_cache             = undef,
  $proxy_cache_enable      = false,
  $proxy_cache_expires     = '864000',
  $proxy_cache_location    = '~* /.*(jpg|jpeg|png|gif|css|mp3|wav|swf|mov|ico|htm|html)$',
  $proxy_cache_pass        = $proxy_pass,
  $proxy_cache_valid       = '200 120m',
  $proxy_connect_timeout   = '60',
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

