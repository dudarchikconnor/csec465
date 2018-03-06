#!/usr/bin/perl
# Connor Dudarchik
# Ping sweeping tool
# Usage: pingsweep.pl 10.10.1.1-10.10.2.50 OR pingsweep.pl 10.10.0.0/16

if ($#ARGV != 0) # If more/less than 1 cmd line arg
{
	print ("Incorrect number of arguments.\n");
	print ("Example usages:\n");
	print ("pingsweep.pl 10.10.1.1-10.10.2.50\n");
	print ("pingsweep.pl 10.10.0.0/16\n");
	exit 1;
}
if (index($ARGV[0], "-") != -1) # If the arg contains a -
{
	my @ips = split /-/, $ARGV[0]; # Get the IPs
	my @ipone = split /\./, $ips[0]; # Separate first IP into octets
	my @iptwo = split /\./, $ips[1]; # Separate second IP into octets
	if($#ipone != 3 || $#iptwo != 3) # Make sure there's 4 octets
	{
		wrong_ip_format();
	}
	foreach $x (@ipone)	# Check each octet in ipone
	{
		if($x < 0 || $x > 255) # Valid number?
		{
			wrong_ip_format();
		}
		if($x =~ /\D/) # Is a number at all?
		{
			wrong_ip_format();
		}
	}
	foreach $x (@iptwo) # Check each octet in iptwo
	{
		if($x < 0 || $x > 255)
		{
			wrong_ip_format();
		}
		if($x =~ /\D/)
		{
			wrong_ip_format();
		}
	}
}
elsif (index($ARGV[0], "\/") != -1) # If the arg contains a /
{
	print ("CIDR Notation\n");
}
else
{
	print ("Incorrect argument format.\n");
	print ("Example usages:\n");
	print ("pingsweep.pl 10.10.1.1-10.10.2.50\n");
	print ("pingsweep.pl 10.10.0.0/16\n");
	exit 1;
}
sub wrong_ip_format
{
	print("Invalid IP address format.\n");
	print("Addresses must be in the format of\n");
	print("x.x.x.x where 0 <= x <= 255\n");
	exit 1;
}
