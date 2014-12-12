# == Class php_fpm::params
#
# This class is meant to be called from php_fpm.
# It sets variables according to platform.
#
class php_fpm::params {
  case $::osfamily {
    'Debian', 'RedHat', 'Amazon': {
      $package_managed  = true
      $package_name     = 'php-fpm'
      $service_managed  = true
      $service_name     = 'php-fpm'
      $prefix           = ''
      $events_mechanism = 'epoll'
    }
    'FreeBSD': {
      $package_managed  = false
      $package_name     = undef
      $service_managed  = true
      $service_name     = 'php-fpm'
      $prefix           = '/usr/local'
      $events_mechanism = 'kqueue'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  $config                      = "$prefix/etc/php-fpm.conf"
  $config_template             = 'php_fpm/php-fpm.conf.erb'
  $include                     = "${prefix}/etc/php-fpm.conf.d"
  $pid                         = '/var/run/php-fpm.pid'
  $error_log                   = '/var/log/php-fpm.log'
  $syslog_facility             = 'daemon'
  $syslog_ident                = 'php-fpm'
  $log_level                   = 'notice'
  $emergency_restart_threshold = '0'
  $emergency_restart_interval  = '0'
  $process_control_timeout     = '0'
  $process_max                 = '0'
  $process_priority            = undef
  $daemonize                   = 'yes'
  $rlimit_files                = undef
  $rlimit_core                 = undef
  $systemd_interval            = '10'

  $pool_config = {
    'www' => {
      user                 => 'www',
      group                => 'www',
      listen               => '/var/run/php-fpm.sock',
      pm                   => 'dynamic',
      pm_max_children      => '5',
      pm_start_servers     => '2',
      pm_min_spare_servers => '1',
      pm_max_spare_servers => '3',
    }
  }
}
