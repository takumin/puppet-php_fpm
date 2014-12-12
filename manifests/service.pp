# == Class php_fpm::service
#
# This class is meant to be called from php_fpm.
# It ensure the service is running.
#
class php_fpm::service {

  if $::php_fpm::service_managed {
    service { $::php_fpm::service_name:
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
