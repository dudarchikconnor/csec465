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
