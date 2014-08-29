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
  $firewall             = true
  $forwarding           = true

  $config_env           = true
  $config_support       = '1'
  $config_roxie         = '1'
  $config_thor          = '1'
  $config_tslave        = '1'
  $config_roxieondemand = true
}
