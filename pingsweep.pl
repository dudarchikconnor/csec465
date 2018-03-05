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
if (index($ARGV[0], "-" != -1)) # If the arg contains a -
{
	print ("IP Range\n");
}
if (index($ARGV[0], "\/" != -1)) # If the arg contains a /
{
	print ("CIDR Notation\n");
}
else
{
	print ("Failure. Like me.\n");
}
