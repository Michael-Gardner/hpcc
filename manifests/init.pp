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
  $hpcc_file_path = $hpcc::params::hpcc_file_path,
  $role           = $hpcc::params::role,
) inherits hpcc::params {
  # validate everything here, in one place
  validate_absolute_path($config_dir,$hpcc_file_path)
  validate_bool($plugin,$service_enable,$service_ensure)
  validate_string($version,$majver,$role)

  anchor { 'hpcc::begin': }
  anchor { 'hpcc::end': }

  class { 'hpcc::dependencies': }
  class { 'hpcc::install': }
  class { 'hpcc::config': }
  class { 'hpcc::service': }

  if ( $role == 'slave' ) {
  # setup resource chain
    Anchor['hpcc::begin'] ->
      Class['hpcc::dependencies'] ->
        Class['hpcc::install'] ->
          Class['hpcc::config'] ~>
            Class['hpcc::service'] ->
              Anchor['hpcc::end']
  }

  if ( $role == 'master' ) {
    class { 'hpcc::keygen': }
    Anchor['hpcc::begin'] ->
      Class['hpcc::dependencies'] ->
        Class['hpcc::install'] ->
          Class['hpcc::keygen'] -> 
            Class['hpcc::config'] ~>
              Class['hpcc::service'] ->
                Anchor['hpcc::end']

  }

}
