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

class hpcc::install {
  if $::hardwaremodel != "x86_64" {
    fail("architecture must be 64bit")
  }

  $ver = $::hpcc::version
  $majver = $::hpcc::majver
  $pname = "hpccsystems-platform_community-"

  case $::operatingsystem {
    'Ubuntu' : {
      $packtype = "dpkg"
      case $::operatingsystemrelease {
        '10.04' : { $pack = "${pname}${ver}lucid_amd64.deb" }
        '12.04' : { $pack = "${pname}${ver}precise_amd64.deb" }
        '12.10' : { $pack = "${pname}${ver}quantal_amd64.deb" }
        '13.04' : { $pack = "${pname}${ver}raring_amd64.deb" }
        '13.10' : { $pack = "${pname}${ver}saucy_amd64.deb" }
        '14.04' : { $pack = "${pname}${ver}trusty_amd64.deb" }
        default : { fail("This version of Ubuntu is not supported") }
      } # end case ::operatingsystemrelease
    } # end case Ubuntu
    'CentOS' : {
      $packtype = "rpm"
      case $::operatingsystemmajrelease {
        '5': { 
          $pack = $::hpcc::plugin ? {
            true    => "${pname}with-plugins-${ver}.el5.x86_64.rpm",
            default => "${pname}${ver}.el5.x86_64.rpm",
          } } # end case CentOS 5
        '6': {
          $pack = $::hpcc::plugin ? {
            true    => "${pname}with-plugins-${ver}.el6.x86_64.rpm",
            default => "${pname}${ver}.el6.x86_64.rpm",
          } } # end case CentOS 6
        default : { fail("Unsupported version of CentOS") }
      } # end case ::operatingsystemmajrelease
    } # end case CentOS
    default  : { fail("Unsupported Operating System") }
  } # end case ::operatingsystem

  package { 'hpccsystems-platform':
    ensure        => $::hpcc::package_ensure,
    provider      => $packtype,
    source        => "/tmp/${pack}",
    allow_virtual => false,
  }

  exec { '/tmp/hpccsystems-platform':
    cwd     => '/tmp',
    command => "/usr/bin/wget http://cdn.hpccsystems.com/releases/CE-Candidate-${majver}/bin/platform/${pack}",
    unless  => '/bin/bash -c \'[[ -e /etc/init.d/hpcc-init ]]\'',
  }

  anchor { 'hpcc::install::begin': }
  anchor { 'hpcc::install::end': }

  Anchor['hpcc::install::begin']->
    Exec['/tmp/hpccsystems-platform']->
    Package['hpccsystems-platform']->
  Anchor['hpcc::install::end']
}
