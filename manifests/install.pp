# == Class php_fpm::install
#
# This class is called from php_fpm for install.
#
class php_fpm::install {

  package { $::php_fpm::package_name:
    ensure => present,
  }
}
