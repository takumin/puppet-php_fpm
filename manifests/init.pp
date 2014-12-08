# == Class: php_fpm
#
# Full description of class php_fpm here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class php_fpm (
  $package_name                = $::php_fpm::params::package_name,
  $service_name                = $::php_fpm::params::service_name,
  $config                      = $::php_fpm::params::config,
  $config_template             = $::php_fpm::params::config_template,
  $include                     = $::php_fpm::params::include,
  $pid                         = $::php_fpm::params::pid,
  $error_log                   = $::php_fpm::params::error_log,
  $syslog_facility             = $::php_fpm::params::syslog_facility,
  $syslog_ident                = $::php_fpm::params::syslog_ident,
  $log_level                   = $::php_fpm::params::log_level,
  $emergency_restart_threshold = $::php_fpm::params::emergency_restart_threshold,
  $emergency_restart_interval  = $::php_fpm::params::emergency_restart_interval,
  $process_control_timeout     = $::php_fpm::params::process_control_timeout,
  $process_max                 = $::php_fpm::params::process_max,
  $process_priority            = $::php_fpm::params::process_priority,
  $daemonize                   = $::php_fpm::params::daemonize,
  $rlimit_files                = $::php_fpm::params::rlimit_files,
  $rlimit_core                 = $::php_fpm::params::rlimit_core,
  $systemd_interval            = $::php_fpm::params::systemd_interval,
  $pool_config                 = $::php_fpm::params::pool_config,
) inherits ::php_fpm::params {

  $pool = merge($::php_fpm::params::pool_config, $pool_config)

  class { '::php_fpm::install': } ->
  class { '::php_fpm::config': } ~>
  class { '::php_fpm::service': } ->
  Class['::php_fpm']
}
