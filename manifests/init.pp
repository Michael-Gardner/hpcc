# Author:   Michael Jon Gardner
# Email:    vintage910@hotmail.com
# Date:     July 9, 2014
# License:  GPL v3
#
# see hpcc::params for information regarding parameters
#
class hpcc
( $plugin         = $hpcc::params::plugin,
  $config_dir     = $hpcc::params::config_dir,
  $service_ensure = $hpcc::params::service_ensure,
  $service_enable = $hpcc::params::service_enable,
  $majver         = $hpcc::params::majver,
  $version        = $hpcc::params::version,
) inherits hpcc::params {
  # validate everything here, in one place
  validate_bool($plugin)
  validate_absolute_path($config_dir)
  validate_bool($service_ensure)
  validate_bool($service_enable)
  validate_string($majver)
  validate_string($version)

  anchor { 'hpcc::begin': }
  anchor { 'hpcc::end': }

  class { 'hpcc::install': }
  class { 'hpcc::config': }
  class { 'hpcc::service': }

  # setup resource chain
  Anchor['hpcc::begin'] ->
    Class['hpcc::install'] ->
      Class['hpcc::config'] ~>
        Class['hpcc::service'] ->
          Anchor['hpcc::end']
}
