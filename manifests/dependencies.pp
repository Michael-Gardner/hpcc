class hpcc::dependencies
{
  
  case $::operatingsystem {
  'Ubuntu': {
    case $::operatingsystemrelease {
    '10.04': { $package_list = ['libboost-regex1.40.0','libicu42',
                                'libxalan110','libxerces-c28',
                                'binutils','libldap-2.4-2','openssl',
                                'zlib1g','g++','openssh-client',
                                'openssh-server','expect','libarchive1',
                                'rsync',] }
    '12.04': { $package_list = ['libboost-regex1.46.1','libicu48',
                                'libxalan110','libxerces-c28','binutils',
                                'libldap-2.4-2','openssl','zlib1g','g++',
                                'openssh-client','openssh-server','expect',
                                'libarchive12','rsync','libapr1',
                                'libaprutil1',]}
    '13.10': { $package_list = ['libboost-regex1.53.0','libicu48',
                                'libxalan-c111','libxerces-c3.1','binutils',
                                'libldap-2.4-2','openssl','zlib1g','g++',
                                'openssh-client','openssh-server','expect',
                                'libarchive13','rsync','libapr1',
                                'libaprutil1']}
    '14.04': { $package_list = ['libboost-regex1.54.0','libicu52',
                                'libxalan-c111','libxerces-c3.1','binutils',
                                'libldap-2.4-2','openssl','zlib1g','g++',
                                'openssh-client','openssh-server','expect',
                                'libarchive13','rsync','libapr1',
                                'libaprutil1']}
    }#end case ::operatingsystemrelease
   }#end case Ubuntu
  'CentOS': {
    case $::operatingsystemmajrelease {
    '5': { $package_list = ['boost141-regex','openldap',
                            'libicu','m4','libtool',
                            'xalan-c','xerces-c','gcc-c++',
                            'openssh-server','openssh-clients',
                            'expect','libarchive','rsync',
                            'apr','apr-util',]}
    '6': { $package_list = ['boost-regex','openldap', 
                            'libicu','m4','libtool','libxslt', 
                            'libxml2','gcc-c++','openssh-server',
                            'openssh-clients','expect','libarchive', 
                            'rsync', 'apr','apr-util',]}
    }#end case ::operatingsystemmajrelease
  }#end CentOS
  }#end case ::operatingsystem
    
  package { $package_list :
    ensure => present,
  }
  
}
