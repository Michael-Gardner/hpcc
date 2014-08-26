# Author:   Michael Jon Gardner
# Email:    vintage910@hotmail.com
# Date:     July 9, 2014
# License:  GPL v3
#
# see hpcc::params for information regarding parameters
#
class hpcc
( $package_installed    = $hpcc::params::package_installed,
  $plugin               = $hpcc::params::plugin,
  $majver               = $hpcc::params::majver,
  $version              = $hpcc::params::version,
  $role                 = $hpcc::params::role,

  $config_env           = $hpcc::params::config_env,
  $config_support       = $hpcc::params::config_support,
  $config_roxie         = $hpcc::params::config_roxie,
  $config_thor          = $hpcc::params::config_thor,
  $config_tslave        = $hpcc::params::config_tslave,
  $config_roxieondemand = $hpcc::params::config_roxieondemand,
) inherits hpcc::params {

  # validation
  validate_bool($plugin,$config_env,$package_installed)
  validate_string($version,$majver,$role,$config_support,$config_roxie)
  validate_string($config_thor,$config_tslave)
  
  $config_roxieondemand_str = $config_roxieondemand ? {
    false   => '2',
    default => '1',
  }

  # end validation


  anchor { 'hpcc::begin': }
  anchor { 'hpcc::end': }

  class { 'hpcc::dependencies': }
  class { 'hpcc::install': }
  class { 'hpcc::config': }

  if ( $role == 'slave' ) {
  # setup resource chain
    Anchor['hpcc::begin'] ->
      Class['hpcc::dependencies'] ->
      Class['hpcc::install'] ->
      Class['hpcc::config'] ->
    Anchor['hpcc::end']
  }

  if ( $role == 'controller' ) {
    class { 'hpcc::keygen': }
    class { 'hpcc::configmgr': }

    Anchor['hpcc::begin'] ->
      Class['hpcc::dependencies'] ->
      Class['hpcc::install'] ->
      Class['hpcc::keygen'] -> 
      Class['hpcc::configmgr'] ->
      Class['hpcc::config'] ->
    Anchor['hpcc::end']
  }

}
