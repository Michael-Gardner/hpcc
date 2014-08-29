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
#   limitations under the License.#   Author: Michael Jon Gardner
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

class hpcc::config {
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
    path   => "/etc/HPCCSystems/environment.xml.puppet",
    ensure => file,
    owner  => 'hpcc',
    group  => 'hpcc',
    mode   => '0644',
    source => 'puppet:///modules/hpcc/environment.xml',
    before => Exec['hpcc/environment.xml'],
  }

  exec { 'hpcc/environment.xml':
    # combine them into this so it's as atomic as we can make it.
    command => '/bin/bash -c \'service hpcc-init stop; /bin/cp environment.xml.puppet environment.xml\'',
    unless  => '/bin/bash -c \'diff environment.xml.puppet environment.xml\'', # diff returns 0 if they match
    cwd     => '/etc/HPCCSystems/',
  }
}
