# Author:   Michael Jon Gardner
# Email:    vintage910@hotmail.com
# Date:     July 9, 2014
# License:  GPL v3
#
# These parameters are used to set default values for your entire HPCC
# cluster.  Set them here and only override when calling the hpcc class
# if absolutely necessary.
#
# plugin
#   type boolean
#   loads the plugin version of hpcc if available instead
#   of the standard package
#
# config_dir
#   type string
#   path to the configuration directory of your hpcc
#   installation
#
# service_ensure
#   type boolean
#   true  for running
#   false for stopped
#
# service_enable
#   type boolean
#   true  for enabled  at boot
#   false for disabled at boot
#
class hpcc::params
{
  $plugin         = false
  $config_dir     = '/etc/HPCCSystems'
  $service_ensure = true
  $service_enable = true
}
