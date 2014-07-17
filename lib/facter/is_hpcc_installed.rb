# is_hpcc_installed.rb
Facter.add('is_hpcc_installed') do
  setcode do
     Facter::Util::Resolution.exec('/bin/bash -c \'rpm -q hpccsystems-platform &> /dev/null; [[ $? == 0 ]] && echo true || echo false\'')
   end
end
