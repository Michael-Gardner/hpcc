# Author:   Michael Jon Gardner
# Email:    vintage910@hotmail.com
# Date:     July 9, 2014
# License:  GPL v3
#
class hpcc::service
{
  service { 'hpcc':
    name       => 'hpcc-init',
    hasrestart => true,
    ensure     => $::hpcc::ensure,
    enable     => $::hpcc::enable,
  }
}
