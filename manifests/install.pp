# Author:   Michael Jon Gardner
# Email:    vintage910@hotmail.com
# Date:     July 9, 2014
# License:  GPL v3
#
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
    ensure        => installed,
    provider      => $packtype,
    source        => "/tmp/${pack}",
  }

  exec { '/tmp/hpccsystems-platform':
    cwd     => '/tmp',
    command => "/usr/bin/wget http://cdn.hpccsystems.com/releases/CE-Candidate-${majver}/bin/platform/${pack}",
    before  => Package['hpccsystems-platform'],
    unless  => '/bin/bash -c \'[[ -e /etc/init.d/hpcc-init ]]\'',
  }
}