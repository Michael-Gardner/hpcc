# Author:   Michael Jon Gardner
# Email:    vintage910@hotmail.com
# Date:     July 9, 2014
# License:  GPL v3
#
# written by binford2k and modified by Michael Gardner
class hpcc::config {
  # strip off ending / if necessary from confdir
  $confdir = regsubst($::hpcc::config_dir, '$/', '')

  # All hpcc services MUST be stopped before changing the
  # environment.xml file
  file { 'authorized_keys':
    path   => '/home/hpcc/.ssh/authorized_keys',
    ensure => file,
    owner  => 'hpcc',
    group  => 'hpcc',
    mode   => '0644',
    source => 'puppet:///modules/hpcc/authorized_keys',
  }

  file { 'id_rsa':
    path   => '/home/hpcc/.ssh/id_rsa',
    ensure => file,
    owner  => 'hpcc',
    group  => 'hpcc',
    mode   => '0600',
    source => 'puppet:///modules/hpcc/id_rsa',
  }

  file { 'id_rsa.pub':
    path   => '/home/hpcc/.ssh/id_rsa.pub',
    ensure => file,
    owner  => 'hpcc',
    group  => 'hpcc',
    mode   => '0600',
    source => 'puppet:///modules/hpcc/id_rsa.pub',
  }

  file { 'hpcc/environment.xml.puppet':
    path   => "${confdir}/environment.xml.puppet",
    ensure => file,
    owner  => 'hpcc',
    group  => 'hpcc',
    mode   => '0644',
    source => 'puppet:///modules/hpcc/environment.xml',
    before => Exec['hpcc/environment.xml'],
  }

  exec { 'hpcc/environment.xml':
    # combine them into this so it's as atomic as we can make it.
    command => '/bin/bash -c \'service hpcc-init stop && /bin/cp environment.xml.puppet environment.xml\'',
    unless  => '/bin/bash -c \'diff environment.xml.puppet environment.xml\'', # diff returns 0 if they match
    cwd     => $confdir,
  }
}
