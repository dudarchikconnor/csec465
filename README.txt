# csec465

----------------------------------------------------------------------------------------------
To run the DNS Enumeration tool (assuming Powershell is configured to run scripts already)
\.enumdns.ps1 input_file
Where the input_file consists of hostnames on a separate line.
----------------------------------------------------------------------------------------------
To run the Ping Sweeper tool in a range:
perl pingsweep.pl a.b.c.d-e.f.g.h
Where the first IP address is lower than the second

To run the Ping Sweeper tool with CIDR notation:
perl pingsweep.pl a.b.c.d/e
Where "e" is either 8, 16, or 24

Good examples:
perl pingsweep.pl 172.217.10.70-172.217.15.75
perl pingsweep.pl 172.217.0.0/16
----------------------------------------------------------------------------------------------
To run the OSdiscover tool:
python OSdiscover ip_file
where ip_file is the list of ip addresses to check, each on their own line
----------------------------------------------------------------------------------------------
To run the Port Scanning tool:
python PortScanner.py
Then, input the IP range to scan, followed by the ports to be scanned.
----------------------------------------------------------------------------------------------
To run the Sniffer tool:
python Sniffer.py
Then, input the interface to scan, followed by filters (if any), TCP ports, and duration.
