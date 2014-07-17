# Author:   Michael Jon Gardner
# Email:    vintage910@hotmail.com
# Date:     July 9, 2014
# License:  GPL v3
#
class hpcc::install {
  if $::hardwaremodel != "x86_64" {
    fail("architecture must be 64bit")           
  }
  case $::operatingsystem {
  'Ubuntu': {
    $packagetype = "dpkg"
    case $::operatingsystemrelease {
    '10.04': { $packagename = "hpccsystems-platform_community-5.0.0-2lucid_amd64.deb" }
    '12.04': { $packagename = "hpccsystems-platform_community-5.0.0-2precise_amd64.deb" }
    '12.10': { $packagename = "hpccsystems-platform_community-5.0.0-2quantal_amd64.deb" }
    '13.04': { $packagename = "hpccsystems-platform_community-5.0.0-2raring_amd64.deb" }
    '13.10': { $packagename = "hpccsystems-platform_community-5.0.0-2saucy_amd64.deb" }
    '14.04': { $packagename = "hpccsystems-platform_community-5.0.0-2trusty_amd64.deb" }   
    default: { fail("This version of Ubuntu is not supported") }
    } # end case ::operatingsystemrelease
  } # end case Ubuntu
  'CentOS': {
    $packagetype = "rpm"
    case $::operatingsystemmajrelease {
    '5': {
      $packagename = $::hpcc::plugin ? {
        true  => "hpccsystems-platform_community-with-plugins-5.0.0-2.el5.x86_64.rpm",
        false => "hpccsystems-platform_community-5.0.0-2.el5.x86_64.rpm",
      }
    } # end case CentOS 5
    '6': { 
      $packagename = $::hpcc::plugin ? {
        true  => "hpccsystems-platform_community-with-plugins-5.0.0-2.el6.x86_64.rpm",
        false => "hpccsystems-platform_community-5.0.0-2.el6.x86_64.rpm",
      }
    default: { fail("Unsupported version of CentOS") }
    } # end case ::operatingsystemmajrelease
  } # end case CentOS
  } # end case ::operatingsystem
    
  package { "hpccsystems-platform":
    ensure   => present,
    provider => $packagetype,
    source   => "/tmp/$packagename",
    require  => File["/tmp/hpccsystems-platform"],
  }

  file { "/tmp/hpccsystems-platform":
    source => "puppet:///modules/hpcc/$packagename"
  }   
}
