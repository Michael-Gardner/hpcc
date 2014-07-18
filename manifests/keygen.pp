class hpcc::keygen
{

$hpcc_file_path = $::hpcc::hpcc_file_path

exec { 'create keys':
  command => 'sudo /opt/HPCCSystems/sbin/keygen.sh',
  unless  => "bash -c \' [[ -e ${hpcc_file_path}/authorized_keys ]] \'",
  path    => '/usr/bin:/bin',
}

exec { 'copy keys':
  cwd         => '/home/hpcc/.ssh',
  command     => "cp id_rsa ${hpcc_file_path} && cp id_rsa.pub ${hpcc_file_path} && cp authorized_keys ${hpcc_file_path} && ls ${hpcc_file_path} && chmod 0644 ${hpcc_file_path}/id_rsa && chmod 0644 ${hpcc_file_path}/id_rsa.pub && chmod 0644 ${hpcc_file_path}/authorized_keys",
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
