#HPCC-Platform

####Table of Contents

1. [HPCC-Platform Overview](#overview)
2. [About the Module](#about-the-module)
3. [Setup](#setup)
    * [Master configuration - What it does](#master-configuration)
	* [Computational Node configuration](#computation-nodes)
4. [Usage](#usage)
    * [Envgen - What it entails](#envgen)
    * [Manual iplist cluster management](#the-iplist-file)
    * [Environment.xml propagation](#environment.xml-propagation)
5. [Limitations](#limitations)
6. [License](#license)
7. [Contact Us](#contact)

##Overview

The HPCC-Platform is a massive parallel-processing computing platform that solves Big Data problems.

##About the Module

This module is designed for a quick and easy installation and setup of the HPCC-Platform cluster on environments utilizing puppet as an administrative tool for linux environments.  It is not designed to be used heavily in production (as having puppet running alongside a roxie or thor node is unnecessary resource overhead.)  Please use this tool to become better aquanted with our implementation of a High Performance Computing Cluster to see if it meets your organizations Big Data needs.  Documentation and whitepapers regarding the running of 
the HPCC-Platform can be found at www.hpccsystems.com.


##Setup

####Master Configuration

####Computation Nodes



##Usage

####Envgen

Envgen is the script that allows us to map nodes in the cluster to specific roles within the HPCC-Platform.


1) .../hpcc/files/iplist must be implemented.  You may use hpcc/files/iplist.example
as a reference for how to format the file.  The iplist file is used to help
generate the environment.xml manifest that will configure all your nodes.

2) .../hpcc/files/environment.xml automatically generated by the hpcc instance with 
role => 'master' set. This instantiation of the hpcc class needs to be on the 
puppetmaster as it controls the generation of environment.xml, as well as acts as a
provider of the file to all the hpcc nodes within your cluster.

##Limitations

The platform is designed and packaged for the following operating systems.  Any other operating systems have not been tested upon.
* CentOS 5
* CentOS 6
* Ubuntu 10.04 LTS
* Ubuntu 12.04 LTS
* Ubuntu 13.10
* Ubuntu 14.04 LTS

##License
-------
    HPCC SYSTEMS software Copyright (C) 2012 HPCC Systems.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

##Contact

In order to contact us, please visit our community forums at http://hpccsystems.com/bb/.


