#!/usr/bin/perl
# Connor Dudarchik
# Ping sweeping tool
# Usage: pingsweep.pl 10.10.1.1-10.10.2.50 OR pingsweep.pl 10.10.0.0/16

if ($#ARGV != 0) # If more/less than 1 cmd line arg
{
	print ("Incorrect number of arguments\n");
	print ("Example usages:\n");
	print ("pingsweep.pl 10.10.1.1-10.10.2.50\n");
	print ("pingsweep.pl 10.10.0.0/16\n");
}
if (index($ARGV[0], "-") != -1) # If the arg contains a -
{
	my @ips = split /-/, $ARGV[0]; # Get the IPs
	my @ipone = split /\./, $ips[0]; # Separate first IP into octets
	my @iptwo = split /\./, $ips[1]; # Separate second IP into octets
	#foreach $x (ipone)
	#{
		
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
}
