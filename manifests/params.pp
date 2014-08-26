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
# role
#   'computation' for a node that will act in the cluster
#   'controller'  goes on the puppet master, where you will run
#     all the hpcc-platform provided tools from to control your node
#
# config_env
#   boolean
#     true -> controller will setup an environment.xml file based upon the
#       following variables.
#     false -> you have to do it yourself with the configmgr program provided
#       by the hpcc-platform, and stage it yourself in the hpcc/files directory
#
# basic configuration setup is for a single node system.  For more information
# about the envgen variables please read the README.md on puppetforge and on our
# github repository, and/or the administration documentation linked therein.

class hpcc::params
{
  $package_installed    = true
  $role                 = 'computation'
  $plugin               = false
  $version              = '5.0.0-2'
  $majver               = '5.0.0'

  $config_env           = true
  $config_support       = '1'
  $config_roxie         = '1'
  $config_thor          = '1'
  $config_tslave        = '1'
  $config_roxieondemand = true
}
