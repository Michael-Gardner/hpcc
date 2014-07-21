class hpcc::configmgr
{

  exec { 'envgen':
    cwd     => $::hpcc::hpcc_file_path,
    command => "/opt/HPCCSystems/sbin/envgen -env ${::hpcc::hpcc_file_path}/newEnvironment.xml -ipfile ${::hpcc::config_iplist} -supportnodes ${::hpcc::config_support} -roxienodes ${::hpcc::config_roxie} -thornodes ${::hpcc::config_thor} -slavesPerNode ${::hpcc::config_tslave} -roxieondemand ${::hpcc::config_roxieondemand}", 
  }
 
  exec { 'master environment.xml':
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    cwd         => $::hpcc::hpcc_file_path,
    command     => 'mv -f newEnvironment.xml environment.xml',
    unless      => 'diff newEnvironment.xml environment.xml',
    refreshonly => true,
  }

  anchor { 'hpcc::configmgr::begin': }
  anchor { 'hpcc::configmgr::end': }

  Anchor['hpcc::config::begin']->
    Exec['envgen']~>
      Exec['master environment.xml']->
        Anchor['hpcc::config::end']

}
