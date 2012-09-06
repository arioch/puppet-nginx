# = Class nginx::install
class nginx::install {
  package { $nginx::pkg_list:
    ensure => $nginx::pkg_ensure,
  }
}
