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
    '5': { }
    '6': { $package_list = [ 'apr', 'apr-util', 'boost-regex', 'libarchive',
            'libtool', 'libxslt', ] }
    }
  }
  }

  package { $package_list :
    ensure => present,
  }
}
