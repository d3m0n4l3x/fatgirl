#!/usr/bin/perl
use IO::Socket::INET;
use Net::DHCP::Packet;
use Net::DHCP::Constants;

use POSIX qw{ strftime };

# sample logger
sub logger($){
	$str = shift;
	print STDOUT strftime "[%d/%b/%Y:%H:%M:%S] ", localtime;
	print STDOUT "$str\n";
	return;
}

print "----------\nusage: $0 \[ORDERS\]\nNo ORDERS are LOOPS!\n----------\n";
$orders = shift;
if(defined($orders)){
	print "ORDERS = $orders\n";
}else{
	print "ORDERS is Loop!\n";
}

if(!defined($orders)){
	$a=1;
	while(1){
			print "\Request Number : $a\n";
    
    	$mac=int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9));
    
    	#open socket for packet tx & rx
    	$socket = IO::Socket::INET->new( Proto => 'udp',
    	Broadcast => 1,
    	LocalPort => 68,
    	PeerAddr =>'255.255.255.255',
    	PeerPort => 67,
    	) || die "Unable to create socket: $@\n";
    
    	$discover = Net::DHCP::Packet->new(
    	xid => int rand(0xFFFFFFFF),
    	Chaddr => $mac,
    	DHO_DHCP_MESSAGE_TYPE() => DHCPDISCOVER(),
    	DHO_VENDOR_CLASS_IDENTIFIER() => 'MyVendorClassID',
    	DHO_DHCP_PARAMETER_REQUEST_LIST() => '1 2 6 12 15 28 67',
    	);
    	$discover->addOptionRaw( 61, pack('H*',$mac));
    
    	logger("Sending DISCOVER to 255.255.255.255:67");
    
    	$socket->send( $discover->serialize() ) or die "Unable to send Discover:$!\n";
    
    	$socket->close();
    
    #	sleep(3);
    	$a++;
	}
}else{
  for($a=1;$a<=$orders;$a++){
  	
  	print "\Request Number : $a\n";
  
  	$mac=int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9)).int(rand(9));
  
  	#open socket for packet tx & rx
  	$socket = IO::Socket::INET->new( Proto => 'udp',
  	Broadcast => 1,
  	LocalPort => 68,
  	PeerAddr =>'255.255.255.255',
  	PeerPort => 67,
  	) || die "Unable to create socket: $@\n";
  
  	$discover = Net::DHCP::Packet->new(
  	xid => int rand(0xFFFFFFFF),
  	Chaddr => $mac,
  	DHO_DHCP_MESSAGE_TYPE() => DHCPDISCOVER(),
  	DHO_VENDOR_CLASS_IDENTIFIER() => 'MyVendorClassID',
  	DHO_DHCP_PARAMETER_REQUEST_LIST() => '1 2 6 12 15 28 67',
  	);
  	$discover->addOptionRaw( 61, pack('H*',$mac));
  
  	logger("Sending DISCOVER to 255.255.255.255:67");
  
  	$socket->send( $discover->serialize() ) or die "Unable to send Discover:$!\n";
  
  	$socket->close();
  
  #	sleep(3);
  }
}

exit(1);