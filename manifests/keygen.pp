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

class hpcc::keygen
{

  exec { 'create keys':
    command => 'sudo /opt/HPCCSystems/sbin/keygen.sh',
    unless  => "bash -c \' [[ -e /home/hpcc/.ssh/authorized_keys ]] \'",
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin', 
  }

  exec { 'copy keys':
    command     => "sudo cp /home/hpcc/.ssh/id_rsa ../files/id_rsa && sudo cp /home/hpcc/.ssh/id_rsa.pub ../files/id_rsa.pub && sudo cp /home/hpcc/.ssh/authorized_keys ../files/authorized_keys && sudo chmod 0644 ../files/id_rsa && sudo chmod 0644 ../files/id_rsa.pub && sudo chmod 0644 ../files/authorized_keys",
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    refreshonly => true,
  }

  anchor { 'hpcc::keygen::begin': }
  anchor { 'hpcc::keygen::end': }

  Anchor['hpcc::keygen::begin'] ->
    Exec['create keys'] ~>
    Exec['copy keys'] ->
  Anchor['hpcc::keygen::end']
}
