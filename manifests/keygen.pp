class hpcc::keygen
{

  exec { 'create keys':
    command => 'sudo /opt/HPCCSystems/sbin/keygen.sh',
    unless  => "bash -c \' [[ -e ../files/authorized_keys ]] \'",
    path    => '/usr/bin:/bin',
  }

  exec { 'copy keys':
    command     => "cp id_rsa ../files/ && cp id_rsa.pub ../files/ && cp authorized_keys ../files/ && chmod 0644 ../files/id_rsa && chmod 0644 ../files/id_rsa.pub && chmod 0644 ../files/authorized_keys",
    path        => '/usr/bin:/bin',
    refreshonly => true,
  }

  anchor { 'hpcc::keygen::begin': }
  anchor { 'hpcc::keygen::end': }

  Anchor['hpcc::keygen::begin'] ->
    Exec['create keys'] ~>
    Exec['copy keys'] ->
  Anchor['hpcc::keygen::end']
}
