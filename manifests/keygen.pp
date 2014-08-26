class hpcc::keygen
{

  exec { 'create keys':
    command => 'sudo /opt/HPCCSystems/sbin/keygen.sh',
    unless  => "bash -c \' [[ -e /home/hpcc/.ssh/authorized_keys ]] \'",
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin', 
  }

  exec { 'copy keys':
    command     => "sudo cp /home/hpcc/.ssh/id_rsa ../files/id_rsa && sudo cp /home/hpcc/.ssh/id_rsa.pub ../files/id_rsa.pub && sudo cp /home/hpcc/.ssh/authorized_keys ../files/authorized_keys && sudo chmod 0644 ../files/id_rsa && sudo chmod 0644 ../files/id_rsa.pub && sudo chmod 0644 ../files/authorized_keys",
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    refreshonly => true,
  }

  anchor { 'hpcc::keygen::begin': }
  anchor { 'hpcc::keygen::end': }

  Anchor['hpcc::keygen::begin'] ->
    Exec['create keys'] ~>
    Exec['copy keys'] ->
  Anchor['hpcc::keygen::end']
}
