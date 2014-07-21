class hpcc::configmgr
{


exec { 'envgen':
  cwd     => $::hpcc::hpcc_file_path,
  command => "/opt/HPCCSystems/sbin/envgen -env ${::hpcc::hpcc_file_path}/newEnvironment -ipfile ${::hpcc::config_iplist} -supportnodes ${::hpcc::config_support} -roxienodes ${::hpcc::config_roxie} -thornodes ${::hpcc::config_thor} -slavesPerNode ${::hpcc::config_tslave} -roxieondemand ${::hpcc::config_roxieondemand}",








}
