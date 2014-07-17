# Author:   Michael Jon Gardner
i# Email:    vintage910@hotmail.com
# Date:     July 9, 2014
# License:  GPL v3
#
# written by binford2k and modified by Michael Gardner
class hpcc::config 
{  
  # strip off ending / if necessary from confdir  
  $_confdir = regsubst($::hpcc::config_dir, '$/', '')

  # All hpcc services MUST be stopped before changing the
  # environment.xml file

  file { 'hpcc/environment.xml.puppet':
    path   => "${_confdir}/environment.xml.puppet",
    ensure => file,
    source => 'puppet://modules/hpcc/environment.xml.puppet',
    before => Exec['hpcc/environment.xml'],
  }
 
  exec { 'hpcc/environment.xml':
    # combine them into this so it's as atomic as we can make it.
    command => 'service hpcc-init stop && /bin/cp environment.xml.puppet environment.xml && service hpcc-init start',
    unless  => '/bin/diff environment.xml.puppet environment.xml', # diff returns 0 if they match
    cwd     => $_confdir,
  }
}
