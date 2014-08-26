class hpcc::configmgr
{
if ( $hpcc::config_env ) {

  exec { 'clean newEnvironment.xml':
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command => 'rm -rf ../files/newEnvironment.xml',
  }

  exec { 'envgen':
    command => "/opt/HPCCSystems/sbin/envgen -env ../files/newEnvironment.xml -ipfile ../files/iplist -supportnodes ${::hpcc::config_support} -roxienodes ${::hpcc::config_roxie} -thornodes ${::hpcc::config_thor} -slavesPerNode ${::hpcc::config_tslave} -roxieondemand ${::hpcc::config_roxieondemand}", 
  }
 
  exec { 'master environment.xml':
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command     => 'mv -f newEnvironment.xml environment.xml',
    unless      => 'diff newEnvironment.xml environment.xml',
    refreshonly => true,
  }

  anchor { 'hpcc::configmgr::begin': }
  anchor { 'hpcc::configmgr::end': }

  Anchor['hpcc::configmgr::begin']->
    Exec['clean newEnvironment.xml'] ->
    Exec['envgen']~>
    Exec['master environment.xml']->
  Anchor['hpcc::configmgr::end']
}
}
