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

class hpcc::dependencies {
  case $::operatingsystem {
    'Ubuntu' : {
      case $::operatingsystemrelease {
        '10.04' : {
          $package_list = [
            'libboost-regex1.40.0',
            'libicu42',
            'libxalan110',
            'libxerces-c28',
            'binutils',
            'libldap-2.4-2',
            'openssl',
            'zlib1g',
            'g++',
            'openssh-client',
            'openssh-server',
            'expect',
            'libarchive1',
            'rsync',
            ]
        }
        '12.04' : {
          $package_list = [
            'libboost-regex1.46.1',
            'libicu48',
            'libxalan110',
            'libxerces-c28',
            'binutils',
            'libldap-2.4-2',
            'openssl',
            'zlib1g',
            'g++',
            'openssh-client',
            'openssh-server',
            'expect',
            'libarchive12',
            'rsync',
            'libapr1',
            'libaprutil1',
            ]
        }
        '13.10' : {
          $package_list = [
            'libboost-regex1.53.0',
            'libicu48',
            'libxalan-c111',
            'libxerces-c3.1',
            'binutils',
            'libldap-2.4-2',
            'openssl',
            'zlib1g',
            'g++',
            'openssh-client',
            'openssh-server',
            'expect',
            'libarchive13',
            'rsync',
            'libapr1',
            'libaprutil1']
        }
        '14.04' : {
          $package_list = [
            'libboost-regex1.54.0',
            'libicu52',
            'libxalan-c111',
            'libxerces-c3.1',
            'binutils',
            'libldap-2.4-2',
            'openssl',
            'zlib1g',
            'g++',
            'openssh-client',
            'openssh-server',
            'expect',
            'libarchive13',
            'rsync',
            'libapr1',
            'libaprutil1']
        }
      } # end case ::operatingsystemrelease
    } # end case Ubuntu
    'CentOS' : {
      case $::operatingsystemmajrelease {
        '5' : {
          $package_list = [
            'boost141-regex',
            'openldap',
            'libicu',
            'm4',
            'libtool',
            'xalan-c',
            'xerces-c',
            'gcc-c++',
            'openssh-server',
            'openssh-clients',
            'expect',
            'libarchive',
            'rsync',
            'apr',
            'apr-util',
            ]
        }
        '6' : {
          $package_list = [
            'boost-regex',
            'openldap',
            'libicu',
            'm4',
            'libtool',
            'libxslt',
            'libxml2',
            'gcc-c++',
            'openssh-server',
            'openssh-clients',
            'expect',
            'libarchive',
            'rsync',
            'apr',
            'apr-util',
            ]
        }
      } # end case ::operatingsystemmajrelease
    } # end CentOS
  } # end case ::operatingsystem


  package { $package_list: 
    ensure => present,    
  }
}
