# hpcc/lib/facter/eclwatch.rb
# returns the location of the eclwatch on our network
Facter.add('eclwatch') do
  setcode do
     output = Facter::Util::Resolution.exec("/bin/bash -c \'ps -e -o comm | grep esp &> /dev/null; [[ $? == 0 ]] && facter ipaddress || echo false\'")
   end
end
