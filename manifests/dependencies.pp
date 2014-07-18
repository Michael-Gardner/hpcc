class hpcc::dependencies
{
  
  case $::operatingsystem {
  'Ubuntu': {
    case $::operatingsystemrelease {
    '10.04': { }
    '12.04': { }
    '13.10': { }
    '14.04': { }
    }
   }
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
    }
  }
  }
  
  if ( !$::is_hpcc_installed ) {
    package { $package_list :
      ensure => present,
    }
  }
}
