#!/usr/bin/perl
# Connor Dudarchik
# Ping sweeping tool
# Usage: pingsweep.pl 10.10.1.1-10.10.2.50 OR pingsweep.pl 10.10.0.0/16
# Good example: pingsweep.pl 172.217.10.70-172.217.15.75

my $wait = 1000; # Time to wait for a response during a ping. 1000 is a good value.

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
	my $result;
	while($ipone[0] <= $iptwo[0]) # If x <= y in x.a.b.c and y.d.e.f
	{
		$result = `ping -n 1 -w $wait $ipone[0].$ipone[1].$ipone[2].$ipone[3]`; # Ping x.a.b.c
		if(index($result, "Reply from") !=- 1)
		{
			print ("$ipone[0].$ipone[1].$ipone[2].$ipone[3] is UP.\n");
		}
		else
		{
			print ("$ipone[0].$ipone[1].$ipone[2].$ipone[3] is DOWN.\n");
		}
		if($ipone[0] == $iptwo[0] && $ipone[1] == $iptwo[1] && $ipone[2] == $iptwo[2] && $ipone[3] == $iptwo[3])
		{
			$ipone[0]++; # Check to see if for loop is done. If so, force out of the loop.
		}
		$ipone[3]++; # Go to the next IP
		if($ipone[3] == 256) # Check for loop around
		{
			$ipone[3] = 0;
			$ipone[2]++;
		}
		if($ipone[2] == 256)
		{
			$ipone[2] = 0;
			$ipone[1]++;
		}
		if($ipone[1] == 256)
		{
			$ipone[1] = 0;
			$ipone[0]++;
		}
	}
		print ("Sweep complete. Terminating.\n");
		exit 0;
}
elsif (index($ARGV[0], "\/") != -1) # If the arg contains a /
{
	my @ipcidr = split /\//, $ARGV[0]; # Get the IP and CIDR block
	my @ip = split /\./, $ipcidr[0]; # Separate IP into octets
	if($#ip != 3) # Make sure there's 4 octets
	{
		wrong_ip_format();
	}
	foreach $x (@ip)	# Check each octet
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
	if (!($ipcidr[1] == 8 || $ipcidr[1] == 16 || $ipcidr[1] == 24)) # Make sure /8 /16 or /24
	{
		print ("CIDR Notation limited to /8, /16, or /24.\n");
		exit 1;
	}
	my $octet; # Determining which octet should increment to 255 before terminating
	if($ipcidr[1] eq 8)
	{
		$octet = 1;
	}
	elsif($ipcidr[1] eq 16)
	{
		$octet = 2;
	}
	else
	{
		$octet = 3;
	}
	my $result;
	while (1) # Loop through.
	{
		if($ip[3] == 256) # Check for loop around
		{
			if($octet == 3) # Detect if we've gone through the CIDR block for /24.
			{
				print ("Sweep complete. Terminating. One.\n");
				exit 0;
			}
			$ip[3] = 0;
			$ip[2]++;
		}
		if($ip[2] == 256) # Detect for /16
		{
			if($octet == 2)
			{
				print ("Sweep complete. Terminating. Two.\n");
				exit 0;
			}
			$ip[2] = 0;
			$ip[1]++;
		}
		if($ip[1] == 256) # Detect for /8
		{
			if($octet == 1)
			{
				print ("Sweep complete. Terminating.\n");
				exit 0;
			}
			$ip[1] = 0;
			$ip[0]++;
		}
		$result = `ping -n 1 -w $wait $ip[0].$ip[1].$ip[2].$ip[3]`; # Ping the address
		if(index($result, "Reply from") !=- 1) # Give a response
		{
			print ("$ip[0].$ip[1].$ip[2].$ip[3] is UP.\n");
		}
		else
		{
			print ("$ip[0].$ip[1].$ip[2].$ip[3] is DOWN.\n");
		}
		$ip[3]++; # Go to next IP
	}
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
