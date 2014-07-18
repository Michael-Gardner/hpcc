class hpcc::keys
{

${hpcc_file_path} = $::hpcc::hpcc_file_path

exec { 'create keys':
  command => 'sudo /opt/HPCCSystems/sbin/keygen.sh',
  before  => Exec['copy keys'],
  onlyif  => '/bin/bash -c \'/sbin/service hpcc-init status &> /dev/null\'',
}

exec { 'copy keys':
  cwd     => '/home/hpcc/.ssh',
  command => "/bin/cp id_rsa ${hpcc_file_path} \
              && /bin/cp id_rsa.pub ${hpcc_file_path} \
              && /bin/cp authorized_keys ${hpcc_file_path} \
              && /bin/ls ${hpcc_file_path} | \
              /usr/bin/xargs -I file chmod 0644 file"



}
