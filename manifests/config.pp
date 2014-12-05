# == Class php_fpm::config
#
# This class is called from php_fpm for service config.
#
class php_fpm::config {

  file { "$::php_fpm::config":
    ensure       => file,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    content      => template($::php_fpm::config_template),
    validate_cmd => "$::php_fpm::prefix/sbin/php-fpm -t -c %",
  }

  file { "$::php_fpm::include":
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0755',
  }

  if $operatingsystem == 'freebsd' {
    include freebsd_newsyslog

    file { '/usr/local/etc/newsyslog.conf.d/php-fpm.conf':
      ensure  => file,
      content => template('php_fpm/newsyslog.conf.erb'),
    }
  }

}
