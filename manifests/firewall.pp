class hpcc::firewall
{
  firewall { '200 allow all necessary hpcc ports':
    dport  => [22, 7010, 20000-20099, 20100-20999],
    action => accept,
    proto  => 'tcp',
  }

  if ($::hpcc::role == 'controller') and ($::hpcc::forwarding) {
    

  }


}
