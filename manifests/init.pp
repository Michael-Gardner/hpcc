#   Author: Michael Jon Gardner
#   Email:  Michael.Gardner@lexisnexis.com
#
#   HPCC SYSTEMS software Copyright (C) 2012 HPCC Systems.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
#   See hpcc::params for more information in regards to optional parameters

class hpcc
( $package_installed    = $hpcc::params::package_installed,
  $plugin               = $hpcc::params::plugin,
  $majver               = $hpcc::params::majver,
  $version              = $hpcc::params::version,
  $role                 = $hpcc::params::role,
  $firewall             = $hpcc::params::firewall,
  $forwarding           = $hpcc::params::forwarding,

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
  if $firewall {
    validate_bool($firewall,$forwarding)
  }

  $config_roxieondemand_str = $config_roxieondemand ? {
    false   => '2',
    default => '1',
  }
  # end validation

  # chaining
  anchor { 'hpcc::begin': }
  anchor { 'hpcc::end': }

  class { 'hpcc::dependencies': }
  class { 'hpcc::install': }
  class { 'hpcc::config': }

  if $firewall {
    class { 'hpcc::firewall': }
  }


  if ( $role == 'computation' ) {
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
