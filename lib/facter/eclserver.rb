# hpcc/lib/facter/eclserver.rb
# returns the location of the eclserver on our network
Facter.add('eclserver') do
  setcode do
     Facter::Util::Resolution.exec('/bin/bash -c \'service ecl; [[ $? == 0 ]] && echo true || echo false\'')
   end
end
