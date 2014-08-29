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

class hpcc::configmgr
{
  if ( $hpcc::config_env ) {

    exec { 'clean newEnvironment.xml':
      path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
      command => 'rm -rf ../files/newEnvironment.xml',
    }

    exec { 'envgen':
      command => "/opt/HPCCSystems/sbin/envgen -env ../files/newEnvironment.xml -ipfile ../files/iplist -supportnodes ${::hpcc::config_support} -roxienodes ${::hpcc::config_roxie} -thornodes ${::hpcc::config_thor} -slavesPerNode ${::hpcc::config_tslave} -roxieondemand ${::hpcc::config_roxieondemand_str}", 
    }
 
    exec { 'master environment.xml':
      path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
      command     => 'mv -f ../files/newEnvironment.xml ../files/environment.xml',
      unless      => 'diff ../files/newEnvironment.xml ../files/environment.xml',
      refreshonly => true,
    }

    anchor { 'hpcc::configmgr::begin': }
    anchor { 'hpcc::configmgr::end': }

    Anchor['hpcc::configmgr::begin']->
      Exec['clean newEnvironment.xml'] ->
      Exec['envgen']~>
      Exec['master environment.xml']->
    Anchor['hpcc::configmgr::end']
  }
}
