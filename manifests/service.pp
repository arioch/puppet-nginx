# = Class nginx
#
class nginx::service {
  service { $nginx::service_name:
    ensure    => $nginx::service_ensure,
    enable    => $nginx::service_enable,
    hasstatus => $nginx::service_hasstatus,
    require   => Class['nginx::config'];
  }
}
